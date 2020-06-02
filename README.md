# 🚀 ShellBin
Redirect your stdout to a bin with ease.

![ShellBin demo](/assets/img/screen.png)

# Why this project?
We wanted to create a fast, beautiful and comfortable service to be able to share the results of our consoles. 
Here is ShellBin, a very simple bin service created in `Vlang`, `Python` and `VueJs`.

## How to install and usage
You can simply download the client from this link: https://github.com/nextblu/shellbin/releases/tag/v1.0.5

After placing the executable in a folder of your choice you can symlink the executable for faster usage with the following code:

#### Unix*
```
chmod +x ./shellbin
sudo ./shellbin symlink
```
#### Windows
```
mklink shellbin.exe "C:\<YOUR_DOWNLOAD_FOLDER>\shellbin.exe"
```

### How do I use it?
Simple!
Just run something like that:
```
$ ls -la | shellbin
```
That's it! ShellBin will capture your stdout and upload the result to the online bin service.

# Privacy?

We do not collect or share any personal information. 
The schema of the database is the following:
```
paste_id
paste_content
url
creation
```

# How to contribute
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.

## License ![alt text](https://img.shields.io/npm/l/express.svg)
[MIT](https://choosealicense.com/licenses/mit/)
