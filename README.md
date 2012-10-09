![AmahiRip][logo]

Introducing **AmahiRip**, the automatic media ripper for the [Amahi Home Server][amahi]. AmahiRip turns your HDA into a CD/DVD ripping appliance. Simply pop in a CD or DVD and AmahiRip will automatically copy the contents of the disc to the appropriate share.

If you insert a DVD, AmahiRip will also encode the DVD into a playable media file using Handbrake. By gathering data about the titles on the DVD, AmahiRip attempts to determine if the disc contains a movie, episodes of a TV series, or some variation of the above. The movie(s) or episode(s) will be encoded as a very high quality MKV file with original audio pass-thru and stereo mixdown (for small TVs), subtitles, English language track detection on foreign language movies, chapters, and seek. Encoding is also scheduled to run on the off hours, so your HDA's performance during the hours that matter most isn't affected. 

To download the original scripts that AmahiRip is based on, visit [flickeringsight's original forum thread][scripts].

## Getting AmahiRip

### Official Releases
You can install official releases of AmahiRip directly from your Amahi HDA's dashboard. Simply visit Setup &raquo; Apps to install.

### Bleeding Edge
If you like to have the latest and greatest and don't mind a few bugs, feel free to grab the code directly off of GitHub and install AmahiRip manually. Instructions for doing so can be found in the [INSTALL][install] file.

## Documentation
We're currently working on documenting AmahiRip.

## Release History
* 0.1 Alpha - Initial build based on flickeringsight's scripts
* 0.2 Alpha - Merged project with MediaRip and switched audio ripping to use RubyRipper

## Questions or problems?
If you have any questions, please feel free to post on the [Amahi Forums][forums] or ask on the [Amahi IRC channel][irc].

[logo]: http://wiki.amahi.org/images/c/cf/AmahiRip_Logo.png
[amahi]: http://www.amahi.org/
[scripts]: http://forums.amahi.org/viewtopic.php?t=1459
[install]: /stevenmirabito/AmahiRip/INSTALL.md
[forums]: http://forums.amahi.org/viewforum.php?f=26
[irc]: http://webchat.freenode.net/?channels=amahi