'''Http upload server with webui, will save incoming files in uploads folder'''
from flask import Flask, request, jsonify
import os
import time

app = Flask(__name__)
upload_folder = './uploads'
if not os.path.exists(upload_folder):
    os.makedirs(upload_folder)

@app.route('/')
def index():
    return '''
    <html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
                color: #333;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }
            .container {
                width: 90%;
                max-width: 400px;
                text-align: center;
                background: #ffffff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            h1 {
                font-size: 1.5rem;
                margin-bottom: 20px;
            }
            .file-input-container {
                position: relative;
                margin-bottom: 20px;
            }
            .file-list {
                text-align: left;
                font-size: 0.9rem;
                margin: 10px 0;
            }
            .file-item {
                display: flex;
                justify-content: space-between;
                border-bottom: 1px solid #ddd;
                padding: 5px 0;
            }
            .upload-btn {
                display: inline-block;
                background-color: #007bff;
                color: white;
                padding: 10px 15px;
                border-radius: 5px;
                font-size: 1rem;
                cursor: pointer;
                text-align: center;
                transition: background-color 0.3s ease;
            }
            .upload-btn:hover {
                background-color: #0056b3;
            }
            .progress-bar {
                width: 100%;
                background-color: #f3f3f3;
                border-radius: 5px;
                overflow: hidden;
                margin-top: 20px;
                height: 10px;
            }
            .progress-bar-inner {
                height: 100%;
                width: 0;
                background-color: #4caf50;
                transition: width 0.4s ease;
            }
            .status {
                margin-top: 10px;
                font-size: 0.9rem;
                color: #555;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Upload Files</h1>
            <div class="file-input-container">
                <input class="file-input" type="file" id="fileInput" multiple>
                <div class="file-list" id="fileList"></div>
            </div>
            <div class="upload-btn" id="uploadButton">Upload</div>
            <div class="progress-bar" id="progressBar">
                <div class="progress-bar-inner" id="progressBarInner"></div>
            </div>
            <p id="status" class="status"></p>
        </div>
        <script>
            const fileInput = document.getElementById('fileInput');
            const fileList = document.getElementById('fileList');
            const uploadButton = document.getElementById('uploadButton');
            const progressBar = document.getElementById('progressBar');
            const progressBarInner = document.getElementById('progressBarInner');
            const status = document.getElementById('status');

            fileInput.addEventListener('change', () => {
                const files = fileInput.files;
                fileList.innerHTML = '';
                let totalSize = 0;
                for (let file of files) {
                    totalSize += file.size;
                    const fileItem = document.createElement('div');
                    fileItem.className = 'file-item';
                    fileItem.innerHTML = `<span>${file.name}</span><span>${(file.size / 1024 / 1024).toFixed(2)} MB</span>`;
                    fileList.appendChild(fileItem);
                }
                status.textContent = `Total Size: ${(totalSize / 1024 / 1024).toFixed(2)} MB`;
            });

            uploadButton.addEventListener('click', () => {
                const files = fileInput.files;
                if (files.length === 0) {
                    status.textContent = 'Please select files to upload.';
                    return;
                }

                const formData = new FormData();
                for (let file of files) {
                    formData.append('files', file);
                }

                const xhr = new XMLHttpRequest();
                xhr.open('POST', '/upload', true);

                const startTime = Date.now();
                xhr.upload.addEventListener('progress', (event) => {
                    if (event.lengthComputable) {
                        const percentComplete = (event.loaded / event.total) * 100;
                        const elapsedTime = (Date.now() - startTime) / 1000;
                        const speed = (event.loaded / 1024 / 1024 / elapsedTime).toFixed(2);
                        progressBar.style.display = 'block';
                        progressBarInner.style.width = percentComplete + '%';
                        status.textContent = `Uploading... ${percentComplete.toFixed(2)}% (${speed} MB/s)`;
                    }
                });

                xhr.onload = () => {
                    if (xhr.status === 200) {
                        progressBarInner.style.width = '100%';
                        status.textContent = 'Upload complete!';
                    } else {
                        status.textContent = 'Upload failed!';
                    }
                };

                xhr.onerror = () => {
                    status.textContent = 'Upload failed!';
                };

                xhr.send(formData);
            });
        </script>
    </body>
    </html>
    '''

@app.route('/upload', methods=['POST'])
def upload_file():
    files = request.files.getlist('files')
    for file in files:
        if file and file.filename != '':
            file.save(os.path.join(upload_folder, file.filename))
    return jsonify({'message': 'Files uploaded successfully'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8081)
