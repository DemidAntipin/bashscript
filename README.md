Как запустить этот скрипт на вашем компьютере:

Подготовительный этап.
1) Если у вас нет git, установите и настройте его. Инструкция: https://www.digitalocean.com/community/tutorials/how-to-install-git-on-ubuntu-20-04-ru
2) Если у вас нет docker, установите и настройте его. Инструкция: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru
3) Склонируйте репозиторий на свой компьютер. git clone https://github.com/DemidAntipin/bashscript

Перейдите в репозиторий: cd bashscript 

4) Запустите процесс коммандой (замените my_program на имя своего процесса): ./my_program &
5) Поймайте PID запущенной программы: program_pid=$!
6) Запустите скрипт и передайте PID в аргументах: ./memory_monitor.sh "$program_pid"
7) Остановите скрипт сочетанием клавишь ctrl + C.
8) Посмотрите результат в файле memory_usage_log.txt.


Как запустить скрипт для docker контейнера.
(Пропустите эти 3 пункта, если вы уже из выполняли).
1) Если у вас нет git, установите и настройте его. Инструкция: https://www.digitalocean.com/community/tutorials/how-to-install-git-on-ubuntu-20-04-ru
2) Если у вас нет docker, установите и настройте его. Инструкция: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru
3) Склонируйте репозиторий на свой компьютер. git clone https://github.com/DemidAntipin/bashscript

Перейдите в репозиторий: cd bashscript

4) Создайте контейнер командой: docker run [опции], подробней о команде можно узнать с помощью docker --help.
5) Если вы не указывали имя контейнера, посмотрите его в списке контейнеров командой: docker ps -a. Нас интересуют колонки container_id и names.
6) Запустите скрипт 1 из команд, в качестве аргумента передайте имя или id контейнера, которые мы узнали в 5-ом пункте:
./memory_monitor.sh <container_name>
./memory_monitor.sh <container_id>
7) Остановите скрипт сочетанием клавишь ctrl + C.
8) Посмотрите результат в файле memory_usage_log.txt.
