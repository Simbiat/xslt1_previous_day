# Get previous date in XSLT 1.0
If you need to get previous date from available one (for example today) but, for some reason, can use only XSLT and only its first version (for example can use only MSXML library), this is the transformation, that will help you do that.

# How to use
Easy: get your date in format like
`<date><dd>31</dd><mm>08</mm><yyyy>2019</yyyy></date>` and apply transformation to it. You will get 3 variables as result: `pdd`, `pmm` and `pyyy`. Obviously, you can (and probably should) update the transformation for tighter integration with your own XSLT: this is more of an example of how this can be done.

# Future updates
I will look into possibility to turn this into an actual date calculation transformation. At the least, it should be possible to allow to get date, say, a week before the selected one. I will not make any promises, though.
