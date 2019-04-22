# atmApp
Приложение для iOS, которое показывает местоположение банкоматов
<br>бэк для этого приложния - https://github.com/godemodegame/atmapp
<br><br><img src="https://github.com/godemodegame/atmMap/blob/master/images/Icon.png" width="250" height="250">
<br>При загрузке приложения, нас встречает таблица, в которой видны все банкоматы, полученные с сервера.
<br>Приложение может работать и в офлайн режиме, json файл с банкоматами, полученный с сервера, сохраняется 
на устройстве. Таким образом последующие разы, когда приложение будет запускаться, пользователю будет выводиться
сначала старые данные, потом, если есть связь, старые будут обновляться на новые. 
Запросы на бэк делаются при запуске tableViewController и в нажатии на navigation bar на кнопку обновить.
<br><br><img src="https://github.com/godemodegame/atmMap/blob/master/images/tableViewController.png" width="300">
<br>В каждой ячейке написан крупным текстом адресс банкомата, серым текстом написан тип и режим работы.
При нажатии на одну из ячеек, появится экран с картой Google, на котором будет стоять метка с геопозицей банкомата, 
на который нажали.
<br><br>При переходе в tabBar в карты, они отоброжаются сразу показав где находится пользователь
Если отдалить камеру, то можно увидеть, что метки собираются в одну, на которой написано их кол-во.
<br><br><img src="https://github.com/godemodegame/atmMap/blob/master/images/mapViewController.png" width="300">
<br>google maps utils "из коробки" может кластерить от 4 меток, чтобы это исправить взял GMUDefaultClusterRenderer.m,
скопировал и изменил значение kGMUMinClusterSize, думая, что мне это поможет решить проблему, когда у 2 маркеров 
одни и те же координаты и видно только один. Проблема осталась не решенной, тк я не нашел как(возможно ли?) посмотреть какие 
обьекты есть в кластере, тогда можно было бы выводить список банкоматов входящих в кластер, наподобие, как выводится одного.
<br><br><img src="https://github.com/godemodegame/atmMap/blob/master/images/marker.png" width="250">
<img src="https://github.com/godemodegame/atmMap/blob/master/images/cluster.png" width="250">
<br>приложение было написано на swift 4.1 только из-за проблем с компьютером
