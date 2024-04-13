4. Safety and Security

To look into safety and security, it is necessary to define these terms properly and understand their meaning. Although you probably heard about this elsewhere already, a quick repetition is not the worst idea.
4.1. Safety

Safety is the attempt to have a system running without being disturbed by its environment or disturbing it. In a computer context, safety means to protect a system against e.g.:

    Flooding

    Power failures

    Fire

and other natural hazards.

Safety does not require for the risk to be eliminated, but to be noticed, to have procedures in place if the it's realised, and to identify an acceptable level of risk.

An example being power failures. One way to deal with them might be to set up massive uninterruptable power supplies (USV), backed by fuel powered generators. Another way might be to automatically save data to the disk every few moments, use a journaling file system and have most desktop users use battery powered laptop computers. In this setup most of the effects of a power failure are being dealt with the impact thus reduced to an acceptable level.

Assessing safety issues is mostly an economic decision, comparing the costs introduced by the incident to the amount spent on countermeasures. A simple formula suggest to multiply the probability of an incident with its assumed costs.

If the probability of a power failure during a day was 0,1% and the only associated risk was the work of the last 10 minutes being lost, because it was not saved, then, with an average salary of 60$ / hour (chosen for easy computation) and 100 employees, the damage would be 1/6h of 60$/h * 100 employees, equals 1000 $. This values the risk at 1 $ per day, 365 $ per year.

If a USV was cheaper, it is worth buying it. If not, usually an entrepreneur would rather run the risk.

However more often than not both the probability is underestimated and the potential damage. The first because even though an event would statistically only happen once every hundred years, two incidents do not need to be a hundred years apart. In a lottery in Israel in 2010, within 6 weeks the wining numbers were the same, 13, 14, 26, 32, 33 and 36, although this should only happen once every 291.000 draws.

The latter is underestimated because it is often not recognised: Thinking about the power outage there is a lot more that might break except for some lost work. When power comes back on most devices need more current to power on. Because of the higher current requirements fuses might blow, conductive tracks or wires might overheat and burn, killing some microelectronics. As a side effect these devices need replacement, adding to the cost and increasing the lost-work cost.

When assuming only the last ten minutes of work would be lost, no one calculated in the duration of the outage: It might well be a lot longer outage as well, with more paid work time lost. If an average power outage was only 10 minutes, the financial loss would double in this example.

Assessing and evaluating safety risks therefore requires thorough analysis. However, this is not the main focus of this course.

    Exercise

Assume you were running a small IT consultancy as a freelancer, you'd be communicating with your customers using both your mobile phone and a pseudo-landline, which in fact is voice-over-IP. Obviously there is email communication as well, with some colleagues you are using several instant messengers and e.g. Skype. Both for your own record but also to avoid legal issues you should be keeping a record of your communication.

Most of your work is either done in your (home) office via these communication means, some requires you to travel to the costumer.

What safety risks would you identify? How would you try to overcome them?

    Exercise

Now, you've become the “CIO” of an internet startup, selling a tiny laser engraver via a web shop offering world wide shipping, credit card payment and 24/7 chat-helpline.

Again you would like to keep track of all the communications, they are stored in a CRM (Customer Relationship Management system), which is hosted in your local server room, as well as all the web-, database-servers needed for the online shop, and the servers needed within your startup. Since the device is produced on-site, the servers supporting the manufacturing process share the same server room, with the production line making heavy use of modern automation technologies.

Your laser engraver is still very new, there is no competitor out yet selling similar products. Although your management considers copying the device is tricky due to specific knowledge about the laser technology included, you would rather not bet on counterfeit products not appearing soon.

What safety risks would you identify? How would you try to overcome them?
4.2. Security

Security is building a system, that resists to at least some extent intentional malicious interaction from humans or other systems.

A good way to remember the difference between safety and security is to look at “workplace safety”, which might require wearing a hard hat, other than “workplace security” which might be (partly) implemented with a “bouncer” checking company ids when entering.

In IT, security usually relates to being unable to access, modify, delete or add data, nor inject arbitrary code into programmes, in a broader meaning that a programme should stay within the execution path intended by its programmer.

To achieve this security needs to be implemented on several layers: Within the programme itself, which should be avoiding all the well known attacks such as buffer overflows or code injections, on the hardware layer, which migh be useful in preventing side-channel attacks, avoiding data extraction by removing or adding devices, such as keyloggers, on an operating system level, which ideally protects running processes from each other, and on the network layer with the well known security goals of authenticity, confidentiality, integrity and non-repudiation.

On a borader scope, availability becomes an additonal IT-security requirement, which is usually achieved by combining security and safety measures on all levels, since availability requires a stable system, which should be able to withstand power failures as well as hackers' attempts to crash the software.

Looking at OS-security, some of the security issues are related to software security and will therefore be addressed in this course, some others are related to the design of the OS, which is more in the scope of an operating systems lecture.

Hardware-Security again has some issues which are easily derived from software-security, this holds especially true for e.g. buffer overflow attacks on firmware, but it has additional issues, which again should addressed in a specific course.
4.3. Networking

For network-security, it is useful to have a quick reminder, albeit the specifics are being covered in courses with a focus on networking, rather than this one. However the main principles authenticity, confidentiality, integrity and non-repudation form the basics of a common understanding of it-security.
4.3.1. Authenticity

Authenticity results from identifying (“authenticating”) partners, usually in a communication setup. In real life this is often done when phoning someone: “Are you Mr. X” initiates authentication. Obviously this is not the highest level of security, since everyone could answer the question with “Yes”.

In real life, often a shared secret is then asked, such as a passphrase, birthday or address. Even though a birthday is hardly to be considered secret with everyone having a profile on social media, more often than not, it is used to verifiy someones identity.

A more reliable proof in everyday live is an ID card or passport, where the country issueing it thereby guarantees to have the identity checked. Although this system is not foolproof either, it requires some more criminal energy to fake one's identity than just answering “yes”.

In an IT world, ID cards are replaced with certificates which were signed by a (more or less) trustworthy authority. Outside networking authentication is often achieved by shared secrets, biometrics or authentication devices such as smart cards. In some situations a combination is used.
4.3.2. Confidentiality

During transmission data might easily be intercepted by a third party. This problem was known long before computers were invented: The ancient Greeks and Romans already used both encryption and steganography to protect messages in transit. A simple symmetric encryption algorithm is still named after Gaius Julius Cesar, who is said to have invented it.

Neither the Greek nor the Romans were shy of abusing slaves to transmit hidden messages: tattooing them on their head, waiting for hair to grow over it and then sending them to the recipient was fairly common. Removing these tattoos was impossible, leaving only bio-degrading or cremating as options to remove evidence. Both aren't exactly compatible with our modern views on human rights.

Again, going into the depths of crypography is not within the scope of this course, there are several lectures offered covering this subject, as well as loads of books for further reading. My personal favourite is Friedrich Ludwig Bauer's book on cryptography, especially since he offers interesting historic comments. Alfred Beutelspacher is often considered to have a very easy to understand style of explaining maths, and Wolfgang Ertel as a local colleague of mine is an obvious recommendation.

For steganography the probably best book is Simon Singh's “hiding in plain sight”.
4.3.3. Integrity

Integrity means data remains unchanged, either during transmission or data stored somewhere. This is usually supported by cryptographically safe hash-algorithms and signatures. Both are covered in great detail in most cryptographic literature.
4.3.4. Non-Repudiation

Once a transaction is done, neither party should be able to deny their actions. An example being online banking: Both the customer nor the bank are bound by their transactions, neither is able to deny it has participated in these.

Non-Repudiation is covered to some extend in the aforementioned literature on cryptography as well as in “Sicherheit im Internet” and in Stallings / Brown.
4.3.5. Exercise

Consider a web shop selling tangible goods such as books or hardware. If you were to implement it, how would you achieve the security goals mentioned in this section?
4.3.6. Exercise

Now consider running a shop selling intangible goods. How would your assessment from the previous exercise change?
4.4. Availability

Availability to some extend is both a security and a safety requirement. Where availability concerns e.g. electrical power etc. it is a safety requirement. Whereas as soon as the software not crashing under attack or being resilient to dDoS-type attacks, is a security requirement.

In most cases IT is crucial for a business to be able to run. The recent attacks with ransomware have demonstrated this, with hospitals failing to be able to fetch patient data or German train provider “Deutsche Bahn” being unable to operate their notification screens (note, their cut through communication cable issues are safety problems, not security)

Allegedly a quite substantial portion of amazon.com's yearly income is earned within a few weeks before christmas. If their servers were unreachable during this period, this would heavily impact their earnings. Since the next shop is only a few clicks away, they run a high risk of loosing their costumer. This is different to “offline” shopping where especially in smaller towns usually not too many shops carry the same product and costumers might also have personal preferences or antipathy towards a specific outlet.

If availability “only” affects the revenue, the risks are easily computable, but what if WiFi-monitoring a patient in an intensive care unit fails? This is potentially life-threatening, e.g. if a cardiac arrest is unnoticed.

What happens if “112”, “911” or “000”, whatever the appropriate emergency call is, is overflowed massively with carefully pre-recorded calls via VoIP? Some emergency services have programmes to take call takers through the emergency call, meant to help them to identify relevant information as quickly as possible. If attackers had calls with appropriate answer prerecorded, potentially with some seconds break in between them, to allow the call taker to ask the next question, they would be able to simply block lines and human capacity.

Availability might be compromised in many ways – from cutting power lines via running a distributed denial of service (dDoS) attack to carefully killing an important process by injecting code into it or simply encrypting the disk. In some cases also an SQL injection might ruin a service – imagine dropping all the shop-data-tables in amazon.com's database.

Many of the network based attacks were discussed in other lectures, whereas those targeting software and their data will be covered in this course. There are also hardware based attacks to availability from inserting USB sticks short circuiting the USB-controller to modify the firmware on all hard disks so they would all “fail” at a specific time. These attacks might be covered in a different course at some point in the future.
4.4.1. Exercise

Imagine you were to implement a wireless ICU-patient monitoring system, alerting medical staff via some kind of mobile device if a patient needs immediate attention. How would you address all the security requirements mentioned in this chapter so far? Would you be able to prioritise them?

While doing so, consider greedy relatives trying to further reduce the remaining lifespan without being caught in order to inherit a fortune.
4.5. Privacy compared to security

Privacy is often considered an important security requirement, since it protects users from being spied at. However some claim privacy to be a security risk since attackers as well would be able to hide their identity.

Hacker ethics, such as these proposed by the Chaos Computer Club, suggest to restrict data acquisition and usage to the necessary minimum, and – surprisingly – found themselves in line with the 2016 EU-GDPR, requiring privacy-by-desing and privacy-by-default.

Both GDPR and Hacker ethics do not prohibit storing data for forensic purposes, but they limit how long this data might be stored and restrict its to forensic analysis instead of say doing some big data analysis to learn more about individuals. There are plenty of ways to protect data from being used otherwise, e.g. by encrypting it to a public key where the public key is split among several entities, who would all need to agree to decrypt.

From a security perspective privacy is very useful: The less data is stored the less an attacker could harvest, hopefully reducing the impact of a data breach. Under the 2016 EU-GDPR a risk assessment is mandatory if personal data is stored. The GDPR requires the risks associated to be minimised to a technologically and economically feasible level.

As far as personal data is concerned the GDPR therefore changed the perspective a bit: Privacy is not a security requirement, but a good level of security is required to protect privacy.

Zuletzt geändert: Montag, 26. Februar 2024, 13:21