#!/bin/sh
cd ~/Programing/blogs/main/blog-cas
zola build
rsync --progress -vrPlu public/   root@slimtux.xyz:/www/wwwroot/blog.slimtux.xyz
