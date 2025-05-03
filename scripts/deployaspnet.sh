dotnet clean && dotnet build
dotnet publish -c Release -o ./publish
rm toupload.zip
cd ./publish
zip -r ../toupload.zip . 
