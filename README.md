# web-timeline  
ДПВ по R: Лабораторная по сбору данных из выдачи поисковой системы.  
  
## Цель работы  
Написание скрипта на языке R, позволяющего отправлять запросы к поисковой системе и сохранять результат в файл (.csv)
  
## Поисковая система  

[Yandex](https://yandex.ru) (Вариант №1)
  
## Структура запросов и временной горизонт  
Временной горизонт 2010 - 2020
* ```query %i``` - обычный запрос
* ```query data:%i**``` - Поиск по страницам с ограничением по дате их последнего изменения, в соотвествии с языком запросов yandex
* ```+query +%i``` - поиск страниц, где встречаются все слова из текста запроса

## Файлы    
 1. ```Make_Timeline.R``` содержит скрипт R для сбора данных.  
 2. ```Timeline.csv``` содержит таблицу с собранными данными. Столбцы таблицы:  
  * **Year** – год, по которому сделан запрос.  
  * **Header** - заголовок статьи.  
  * **Source** - источник новости (адрес информационного источника, который виден на странице выдачи поисковика).  
  * **URL** - полная ссылка на источник.  
