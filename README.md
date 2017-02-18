# Smug
Smug is a command line utility for Unix-like operating system. 
It allows the automation in the **installation/update** of some software, such as **PHP 7.0**, 
**PHPMyAdmin**, **NPM**, **Node.js** and **Laravel Installer** in the **Cloud9 workspaces**.

The Smug was designed for not to be installable, for simplicity. Is only a **Shell Script**.

## Clone Smug repository
```bash
$ git clone https://github.com/cristiancmello/smug.git
```

## Smug usage

### Show help
```bash
$ ./smug --help
```

### Prepare Workspace
* Install/Update **PHP 7.0**, **PHPMyAdmin**, **Laravel Installer** (through Composer Package Manager) and **NPM**:
```bash
$ ./smug --prepare --laravel-all
```

* Installing individually:
    - Install **PHP 7.0** (with **php7.0-sqlite3** and **php7.0-mysql**):
    ```bash
    $ ./smug --prepare --php7.0
    ```
    
	- Install **PHPMyAdmin** (MySQL connection, by default):
    ```bash
    $ ./smug --prepare --phpmyadmin
    ```

    - Install **Laravel Installer**:
    ```bash
    $ ./smug --prepare --laravel-installer
    ```
    
    - Install **NPM**:
    ```bash
    $ ./smug --prepare --npm
    ```
    
    - Install/Update **Node.js 6.9.4 LTS**:
    ```bash
    $ ./smug --prepare --node
    ```
    
### Project Creation
* Create Laravel Project (*with* Cloud9's public index folder path configuration):
```bash
    $ ./smug --create --laravel-project --public-index-folder <project_name>
```

* Create Laravel Project (*without* Cloud9's public index folder path configuration):
```bash
    $ ./smug --create --laravel-project <project_name>
```

### Workspace Configuration
* Configure Cloud9's public index folder path:
```bash
    $ ./smug --configure --public-index-folder <folder_name>
```
