# Assessment 1

**Author:** Waldemar Schwab  
**Created on:** 2024-04-30  
**Fernuniversität Hagen** IT-Forensik



## 1
### Please describe the differences between forensic investigation and incident response. (15)
In cybersecurity, forensic investigation and incident response serve essential but distinct functions when dealing with security incidents. Forensic investigation is primarily concerned with uncovering the facts about a cybersecurity incident. It aims to determine how an incident occurred, identify the perpetrators, and gather evidence for legal proceedings. The focus is on reconstructing the sequence of events in detail to establish an accurate timeline and understand the intricacies of the incident.

#### Main Goals
In contrast, the main goal of incident response is to quickly contain and mitigate the impact of a cybersecurity incident. This process is about rapid identification, containment, and eradication of threats, followed by restoration of systems to their normal states. Incident response prioritizes reducing damage, shortening recovery times, and preventing future incidents through immediate action.

#### Aproach
The approach to each discipline also differs significantly. Forensic investigation involves a methodical process of evidence identification, data preservation, artifact analysis, and documentation to maintain data integrity and admissibility in court.

On the other hand, incident response follows a structured protocol outlined in an Incident Response Plan (IRP), which includes preparation, detection, analysis, containment, eradication, and recovery. Tools used in this realm are designed for speed and efficiency, including SIEM systems, IDS, and automated remediation tools. The techniques focus on real-time monitoring and anomaly detection to quickly address threats.

#### Documentation
Both fields require thorough documentation, though their purposes diverge. Forensic investigation documentation must be precise and is structured for use in legal contexts, often needed to be understood by non-technical stakeholders such as law enforcement or legal teams. Conversely, documentation in incident response records the incident’s timeline and impact to inform internal and sometimes regulatory stakeholders, focusing on resolution and prevention strategies.


Ultimately, the outcomes of each process also reflect their differing objectives. Forensic investigations aim to provide a comprehensive understanding of the incident, support potential legal actions against the perpetrators, and inform broader security policies. In contrast, incident response seeks to minimize business disruption and make strategic recommendations to bolster defenses against future attacks.

## 2
### Please identify how and where the forensic principles by BSI, Casedy and Freiling differ. (15)


EMPTY  
EMPTY  
EMPTY  
EMPTY  
EMPTY  
EMPTY  
EMPTY  
EMPTY  
EMPTY  
EMPTY  
EMPTY  EMPTY  EMPTY  EMPTY  EMPTY  EMPTY  EMPTY  EMPTY  
EMPTY
EMPTY
EMPTY
EMPTY
EMPTY
EMPTY
EMPTY
EMPTY

## 3
### For the following cases, argue why you prefer either a "clean" forensic process or incident response - and how you would mix and match to optimise your result:

* Reacting to a ransomware attack
* suffering of a dDoS-attack
* suffering of DoS due to a buffer overflow in a network daemon (20)

### Preface
At first the answer depends on the environment. So I'll try to give a general answer without assuming a specific environment.  

### Reacting to a ransomware attack
When confronted with a ransomware attack, the immediate priorities typically focus on recovering lost data, preventing future attacks, and restoring system functionality promptly.

It's rare for perpetrators of such attacks to be apprehended and held financially accountable, making it unlikely that a forensic investigation will directly lead to the recovery of damages. However, conducting a basic forensic analysis is still advisable. This can provide essential insights, such as identifying the specific ransomware variant, understanding how it penetrated the system, detailing the extent of the damage, and outlining measures to prevent similar attacks in the future. Such information is invaluable during the system recovery process.

Ransomware attacks are often highly automated, and it's probable that the particular strain involved has already been documented. There may even be ongoing governmental investigations into the attack. Nonetheless, the primary objective remains to swiftly restore operational capacity through effective incident response. This approach ensures that immediate threats are managed while also laying the groundwork for strengthened defenses against potential future attacks.

### Suffering of a dDoS-attack
When suffering from a DDoS attack without any preparations (otherwise, you would not be suffering), it is improbable that you will get your services up without the help of other services like a CDN, Cloudflare Proxy, or similar cloud-based services. Operating in these environments is not just a question of money, but also of time and preparation. Therefore, we should focus on the forensic process as it is likely that a competitor might be behind this attack.


### Suffering of DoS due to a buffer overflow in a network daemon
In this case, I would say it's an economic decision whether you want to invest the time in the forensic process or opt for a fast incident response. There is a good chance that you can capture some malicious packets which caused the buffer overflow. However, the forensic process thereafter will take a significant amount of time. The buffer overflow can be resolved on your machine, but the solution may still take some time to implement.

## 4
### Could you provide an automated script to identify files with a "tampered" extension - i.e. a .jpg hiding as .odt? (20)

```bash
#!/bin/bash

# Directory to scan
search_directory="$1"

# Check if search directory is provided
if [ -z "$search_directory" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if 'file' command is available
if ! command -v file &> /dev/null
then
    echo "'file' command could not be found, please install it to use this script."
    exit 1
fi

echo "Scanning directory '$search_directory' for files with mismatched content types..."

# Find all files and check their MIME type against their extension
find "$search_directory" -type f -print0 | while IFS= read -r -d $'\0' file; do
    # Get the MIME type of the file
    mimetype=$(file --mime-type -b "$file")
    
    # Extract the extension of the file
    extension="${file##*.}"

    # Define expected MIME type based on file extension
    # This list can be expanded as needed
    case "$extension" in
        jpg|jpeg)
            expected_mime="image/jpeg"
            ;;
        png)
            expected_mime="image/png"
            ;;
        gif)
            expected_mime="image/gif"
            ;;
        txt)
            expected_mime="text/plain"
            ;;
        pdf)
            expected_mime="application/pdf"
            ;;
        odt)
            expected_mime="application/vnd.oasis.opendocument.text"
            ;;
        *)
            expected_mime=""
            ;;
    esac

    # Check if the detected MIME type matches the expected MIME type
    if [[ -n "$expected_mime" && "$mimetype" != "$expected_mime" ]]; then
        echo "Mismatch found: '$file' has extension .$extension but MIME type is $mimetype."
    elif [[ -z "$expected_mime" ]]; then
        echo "No expected MIME type for .$extension, detected MIME type is $mimetype."
    fi
done

echo "Scan complete."

```

## 5
### How would you suggest to delete a file in a forensically sound manner? (10)
It's important to not only unlink the file from the filesystem but also overwrite all the physical bits. It's often recommended to overwrite those bits multiple times (3 times as recommended by the US Department of Energy). This can be achieved by using the `shred` command in Linux.

Another way could be by saving the data encrypted and then discarding the encryption key. This way, the data remains, but it's no longer readable.

## 6
### Looking at VeraCrypt's hidden volumes: Does a tool like tchunt actually find these? If not, what does it find - and if so, how? (20)

