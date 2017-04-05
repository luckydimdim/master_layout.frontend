Главный макет.

Настройка транспиллера SCSS в WebStorm:
1) создать watcher SCSS
2) указать путь к scss, напр. "Program: d:\Env\ChocolateyTools\ruby23\bin\scss.bat"
3) задать следующие аргументы --no-cache --update $FileName$:$FileNameWithoutExtension$.css -I $ContentRoot$\web
4) указать output path $FileNameWithoutExtension$.css:$FileNameWithoutExtension$.css.map
5) снять чекбок "track only root files"

Обновление bower компонентов:
1) В каталоге .\lib\src\ обновить файл bower.json и запустить bower update