## Icons

The following icons copied from https://icons8.com/.

* camera@2x.png
* list@2x.png

## Create Launch Images

```
$ # iPhone Portrait iOS 8,9 Retina HD 5.5
$ convert -size 1242x2208 xc:white Default-736h@3x~iphone.png
$ # iPhone Portrait iOS 8,9 Retina HD 4.7
$ convert -size 750x1334 xc:white Default-667h@2x~iphone.png
$ # iPhone Portrait iOS 7-9 2x
$ convert -size 640x960 xc:white Default@2x~iphone.png
$ # iPhone Portrait iOS 7-9 Retina 4
$ convert -size 640x1136 xc:white Default-568h@2x~iphone.png
$ # iPad Portrait iOS 7-9 1x
$ convert -size 768x1024 xc:white Default-Portrait~ipad.png
$ # iPad Portrait iOS 7-9 2x
$ convert -size 1536x2048 xc:white Default-Portrait@2x~ipad.png
```
