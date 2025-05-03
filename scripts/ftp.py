'''Scripts to open webui for viewing system files/disks'''
import os
import datetime
import zipfile
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import unquote, quote
import psutil  
import platform  
host = "0.0.0.0"
port = 8000
class DirectoryListingHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        raw_path = unquote(self.path)
        path = os.path.abspath(raw_path) 
        print(f"Resolved absolute path: {path}")

        if path == "/":
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            self.wfile.write(self.list_drives().encode()) 
            return

        elif path == "/root":
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            self.wfile.write(self.list_directory("/").encode())  
            return

        if path.startswith("/download_folder"):
            folder_path = os.path.normpath(path[len("/download_folder/"):]) 
            folder_path = os.path.join("/", folder_path)  
            print(f"Resolved download folder path: {folder_path}")

            if not os.path.exists(folder_path):
                self.send_response(404)
                self.send_header('Content-type', 'text/plain')
                self.end_headers()
                self.wfile.write(f"Error: Path '{folder_path}' not found or inaccessible.".encode())
                return

            zip_file_path = self.send_zip(folder_path)
            self.send_response(200)
            self.send_header('Content-type', 'application/zip')
            self.send_header('Content-Disposition', f'attachment; filename={os.path.basename(zip_file_path)}')
            self.end_headers()
            with open(zip_file_path, 'rb') as f:
                self.wfile.write(f.read())
            os.remove(zip_file_path)
            return

        if os.path.isdir(path):
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            self.wfile.write(self.list_directory(path).encode())
            return

        if os.path.isfile(path):
            self.send_file_content(path)
            return

        self.send_response(404)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()
        self.wfile.write(f"Error: Path '{path}' is not valid.".encode())

    def list_drives(self):
        drives_info = []
        
        if platform.system() == 'Windows':
            import string
            from ctypes import windll

            drives = [f"{d}:\\" for d in string.ascii_uppercase if windll.kernel32.GetDriveTypeW(f"{d}:\\") != 1]
            for drive in drives:
                total, used, free = self.get_drive_space(drive)
                drives_info.append(f"""
                    <tr>
                        <td><a href='/{drive}'>{drive}</a></td>
                        <td>{total:.2f} GB</td>
                        <td>{used:.2f} GB</td>
                        <td>{free:.2f} GB</td>
                        <td>
                            <div style="width: 100%; background-color: #e0e0e0; border-radius: 4px; position: relative; height: 20px;">
                                <div style="width: {used / total * 100 if total else 0}%; background-color: #76c7c0; height: 100%; border-radius: 4px;"></div>
                            </div>
                        </td>
                    </tr>
                """)
        else:
            for partition in psutil.disk_partitions():
                if partition.mountpoint == "/":
                    href = "/root"  
                else:
                    href = quote(partition.mountpoint)

                total, used, free = self.get_drive_space(partition.mountpoint)
                drives_info.append(f"""
                    <tr>
                        <td><a href='{href}'>{partition.mountpoint}</a></td>
                        <td>{total:.2f} GB</td>
                        <td>{used:.2f} GB</td>
                        <td>{free:.2f} GB</td>
                        <td>
                            <div style="width: 100%; background-color: rgb(224, 224, 224); border-radius: 4px; position: relative; height: 20px;">
                                <div style="width: {used / total * 100 if total else 0}%; background-color: rgb(118, 199, 192); height: 100%; border-radius: 4px;"></div>
                            </div>
                        </td>
                    </tr>
                """)

        html = f"""
        <html>
        <head>
            <title>Available Drives</title>
            <style>
                body {{ font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }}
                .container {{ width: 80%; margin: 20px auto; padding: 20px; background: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }}
                h1 {{ font-size: 24px; margin-bottom: 20px; }}
                table {{ width: 100%; border-collapse: collapse; }}
                td, th {{ padding: 10px; border-bottom: 1px solid #ddd; }}
                th {{ background-color: #f2f2f2; }}
                tr:nth-child(even) {{ background-color: #f9f9f9; }}
                a {{ text-decoration: none; color: #0066cc; }}
                a:hover {{ text-decoration: underline; }}
            </style>
        </head>
        <body>
            <div class='container'>
                <h1>Available Drives</h1>
                <table>
                    <thead>
                        <tr><th>Drive</th><th>Total Space</th><th>Used Space</th><th>Free Space</th><th>Usage</th></tr>
                    </thead>
                    <tbody>
                        {''.join(drives_info)}
                    </tbody>
                </table>
            </div>
        </body>
        </html>
        """
        return html




    def list_directory(self, path):
        items = []
        try:
            host = self.headers.get('Host') 
            base_url = f"http://{host}" 

            for entry in os.listdir(path):
                full_path = os.path.join(path, entry)
                full_url = f"{base_url}/{quote(full_path)}" 
                
                if os.path.isfile(full_path):
                    size_bytes = os.path.getsize(full_path)
                    size_mb = size_bytes / (1024 * 1024) 
                    size_display = f"{size_mb:.2f} MB"
                else:
                    size_display = "-"

                mtime = datetime.datetime.fromtimestamp(os.path.getmtime(full_path)).strftime('%Y-%m-%d %H:%M:%S')

                download_link = f"<a href='/download_folder/{quote(full_path)}'>Download as ZIP</a>" if os.path.isdir(full_path) else ""

                if os.path.isdir(full_path):
                    items.append(f"<tr><td><a href='{full_url}'>{entry}/</a></td><td>Directory</td><td>{mtime}</td><td>{download_link}</td></tr>")
                else:
                    items.append(f"<tr><td><a href='{full_url}'>{entry}</a></td><td>{size_display}</td><td>{mtime}</td><td></td></tr>")
        except Exception as e:
            items.append(f"<tr><td colspan='4'>Error: {str(e)}</td></tr>")

        parent_dir = os.path.dirname(path)
        parent_link = f"<tr><td colspan='4'><a href='{base_url}/{quote(parent_dir)}'>.. (Parent Directory)</a></td></tr>" if path != '/' else ""
        
        html = f"""
        <html>
        <head>
            <title>Directory Listing</title>
            <style>
                body {{ font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }}
                .container {{ width: 80%; margin: 20px auto; padding: 20px; background: #fff; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }}
                h1 {{ font-size: 24px; margin-bottom: 20px; }}
                table {{ width: 100%; border-collapse: collapse; }}
                th, td {{ padding: 10px; border-bottom: 1px solid #ddd; text-align: left; }}
                th {{ background-color: #f2f2f2; }}
                tr:nth-child(even) {{ background-color: #f9f9f9; }}
                a {{ text-decoration: none; color: #0066cc; }}
                a:hover {{ text-decoration: underline; }}
            </style>
        </head>
        <body>
            <div class='container'>
                <h1>Directory Listing</h1>
                <table>
                    <thead>
                        <tr><th>Name</th><th>Size</th><th>Last Modified</th><th>Download</th></tr>
                    </thead>
                    <tbody>
                        {parent_link}
                        {''.join(items)}
                    </tbody>
                </table>
            </div>
        </body>
        </html>
        """
        return html




    def send_zip(self, path):
        try:
            if not os.path.isdir(path):
                self.send_response(404)
                self.end_headers()
                return

            self.send_response(200)
            self.send_header('Content-type', 'application/zip')
            self.send_header('Content-Disposition', f'attachment; filename="{os.path.basename(path)}.zip"')
            self.end_headers()

            with zipfile.ZipFile(self.wfile, 'w', zipfile.ZIP_DEFLATED) as zf:
                for root, dirs, files in os.walk(path):
                    for file in files:
                        zf.write(os.path.join(root, file))

        except Exception as e:
            self.send_response(500)
            self.end_headers()
            self.wfile.write(f"Error: {str(e)}".encode())

    def send_file_content(self, path):
        CHUNK_SIZE = 65536
        try:
            with open(path, 'rb') as file:
                self.send_response(200)
                self.send_header('Content-type', 'text/plain')
                self.send_header('Content-Length', str(os.path.getsize(path)))
                self.end_headers()
                while chunk := file.read(CHUNK_SIZE):
                    self.wfile.write(chunk)
        except Exception as e:
            self.send_response(500)
            self.end_headers()
            self.wfile.write(f"Error: {str(e)}".encode())

    def get_drive_space(self, path):
        try:
            usage = psutil.disk_usage(path)
            total = usage.total / (1024 ** 3)  
            used = usage.used / (1024 ** 3)
            free = usage.free / (1024 ** 3)
            return total, used, free
        except Exception as e:
            print(f"Error getting space for {path}: {e}")
            return 0, 0, 0


def run(server_class=HTTPServer, handler_class=DirectoryListingHandler):
    server_address = (host,port)
    httpd = server_class(server_address, handler_class)
    print(f"Serving HTTP on port {port}...")
    httpd.serve_forever()


if __name__ == "__main__":
    run()


