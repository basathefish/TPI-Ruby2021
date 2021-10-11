# Introducción

Polycon es una herramienta desarrollada para gestionar la agenda de turnos de un policonsultorio, en el cual atienden profesionales de diferentes especialidades
La herramienta fue implementada como proyecto para el taller de tecnologías de producción de software, Opción Ruby, de la Universidad Nacional De La Plata

## Instalación de dependencias

Este proyecto utiliza Bundler para el manejo de dependencias.
De modo que Bundler se encarga de instalar las dependencias ("gemas")
que el proyecto tenga declaradas en el archivo `Gemfile` al ejecutar el siguiente comando:

```bash
$ bundle install
```

> Nota: Bundler debería estar disponible en tu instalación de Ruby, pero si por algún
> motivo al intentar ejecutar el comando `bundle` obtenés un error indicando que no se
> encuentra el comando, podés instalarlo mediante el siguiente comando:
>
> ```bash
> $ gem install bundler
> ```

Una vez que la instalación de las dependencias sea exitosa (esto deberías hacerlo solamente
cuando estés comenzando con la utilización del proyecto), podés comenzar a probar la
herramienta.

## Uso de `polycon`

Para ejecutar el comando principal de la herramienta se utiliza el script `bin/polycon`,
el cual puede correrse de las siguientes manera:

```bash
$ ruby bin/polycon [args]
```

O bien:

```bash
$ bundle exec bin/polycon [args]
```

O simplemente:

```bash
$ bin/polycon [args]
```

Si se agrega el directorio `bin/` del proyecto a la variable de ambiente `PATH` de la shell,
el comando puede utilizarse sin prefijar `bin/`:

```bash
# Esto debe ejecutarse estando ubicad@ en el directorio raiz del proyecto, una única vez
# por sesión de la shell
$ export PATH="$(pwd)/bin:$PATH"
$ polycon [args]
```

> Notá que para la ejecución de la herramienta, es necesario tener una versión reciente de
> Ruby (2.6 o posterior) y tener instaladas sus dependencias, las cuales se manejan con
> Bundler. Para más información sobre la instalación de las dependencias, consultar la
> siguiente sección ("Desarrollo").

# Decisiones de diseño

Para la implementación del proyecto, se utilizó un módulo “Models” el cual abarca la funcionalidad que el proyecto posee a través de sus clases “Professional” y “Appointment”, las cuales se pueden encontrar en la ruta `lib/polycon/models/` dentro de los archivos `profesional.rb` y `appointment.rb` respectivamente

Además de esto, también se implementó un módulo “Helpers”, el cual brinda distintos métodos de apoyo a las clases ya mencionadas
Este módulo puede encontrarse siguiendo la ruta `lib/polycon/Helpers.rb`

Como información extra, los mensajes de respuesta del sistema, ya sea en caso de haber realizado exitosamente la acción indicada, o en caso de fallar en alguna operación, se realizan a través de la consola de comandos en lenguaje español

## Información sobre la clase Professional

La implementación de esta clase posee los siguientes comportamientos de clase:

-`initialize`: inicializa una instancia de la clase Professional en base al nombre recibido por parámetro

-`create_folder`: Crea la carpeta perteneciente al profesional que lo llame

-`exist?`: Verifica la existencia de un profesional ya registrado en el sistema

-`rename_professional`: Renombra la carpeta perteneciente al profesional enviado por parámetro por un nuevo nombre también recibido por parámetro

-`list_professionals`: Lista los nombres de los profesionales cargados en el sistema, en caso de no haberlos, el sistema informará de esto

-`delete_professional`: Elimina la carpeta perteneciente al profesional recibido por parámetro, en caso de un fallo o que el directorio no se encuentre vacío, el sistema informara de esto

## Sobre el código de Professional en Commands

Los comandos referentes a los profesionales poseen una verificación en caso de haber realizado exitosamente la acción indicada

Además de estos, también se incluyeron validadores para los parámetros recibidos y un verificador en caso de que el profesional ingresado ya posea una carpeta a su nombre
Para la validación de parámetros se utilizó el método `validate_field` del módulo `Helpers`, el cual informa al usuario en caso de haber enviado un parámetro invalido (strings vacíos o con los caracteres “\” o “/”)

Sumado a esto, commands le da uso al método `polycon_exist?` para asegurar la existencia de la carpeta `.polycon`

## información sobre la clase Appointment

La implementación de esta clase posee los siguientes comportamientos de clase:

-`initialize`: Inicializa una instancia de la clase Appointment en base a los datos recibidos por parámetro

-`create_file`: Crea el archivo de texto plano .paf, almacenando la información que la instancia posea, esta información es guardada con un dato por línea en un array en el interior del archivo, de modo que esto facilite la futura lectura y modificación de dicha información

-`exist?`: Verifica si el archivo indicado existe dentro del profesional recibido por parámetro

-`show_file`: Busca y muestra la información almacenada en el archivo indicado en base a los parámetros recibidos. La información se muestra de forma “tipoDeDato: Dato” (ej. Nombre: Damian)

-`cancel_appointment`: Busca y elimina el archivo de la cita indicada a través de los parámetros recibidos 
En caso de no poder eliminarlo, el sistema informa de esto

-`cancel_all_files`: Elimina todos los archivos almacenados dentro de la carpeta del profesional indicado por parámetro
En caso de no poder eliminar los archivos, el sistema informa de esto

-`rename_file`: Busca y cambia el nombre del archivo indicado por parámetro, por el nuevo nombre también indicado por el mismo medio
Al igual que con el “cancel_appointment”, en caso de no poder renombrar el archivo, el sistema informará de esto

-`list_appointments`: Imprime en pantalla los nombres de los archivos almacenados dentro del profesional indicado por parámetro
Además de esto, también es posible indicarle una fecha, de la cual el sistema filtrara para mostrar en pantalla solo los turnos de la fecha indicada (la fecha debe estar en formato `AAAA-MM-DD`)

-`edit_file`: El sistema busca el archivo indicado y sobrescribe la información indicada por parámetros, para esto, se recibe un hash y se convierte en hash el arreglo almacenado, de modo que en caso de que alguna clave coincida en ambos, el valor será actualizado por el indicado el hash recibido

Como se mencionó anteriormente, los datos del archivo se almacenarán en el formato de array. Esto es debido a la facilidad que brinda a la hora de trabajar con estos datos, además de la ordenada presentación que brinda a la hora de abrir uno de estos archivos, los cuales almacenan la información de modo “un dato por línea”

## Sobre el código de Appointments en Commands

Los comandos referentes a las Citas, al igual que para los profesionales, poseen una verificación en caso de haber realizado exitosamente la acción indicada, además de validadores para cada campo requerido, para esto se utilizó el método `validate_field` dentro del módulo Helpers

En caso de no enviar los parámetros solicitados por el comando, este se instanciará en un string vacío `“”`, de modo que el validador le indicara que dicho campo no es valido

Además de este validador, todos los comandos cuentan con uno o más verificadores para las rutas deseadas, es decir que verifican si el profesional ingresado se encuentra registrado en el sistema, así como verificar si el archivo sobre el cual se desea actuar también se encuentra registrado en el sistema
Por ejemplo en caso de querer leer un archivo “2021-07-18 11-11” dentro de una carpeta “Armando Esteban”, el validador mencionado verificará si dicha carpeta y archivo existen en el sistema

Sumado a esto, commands le da uso al método `polycon_exist?` para asegurar la existencia de la carpeta `.polycon`


## Acerca del módulo Helpers

Este módulo implementa distintos métodos de apoyo, así como herramientas útiles para distintas secciones del proyecto
dichos métodos son los siguientes:

-`polycon_exist? `: Este método verifica si existe la carpeta `.polycon` dentro del directorio “home” del usuario. En caso de no existir, el sistema informará de esto y creará dicha carpeta, informando al usuario de esto mismo
Este método es utilizado en el modulo Commands, como forma de la carpeta `.polycon` siempre exista en el sistema a la hora de ejecutar algún comando

-`validate_field`: Este método es el encargado de validar que los parámetros ingresados son válidos, es decir, que no se trate de un string vacío “” ni un string que contenga los caracteres “/” ni “\”, esto para no generar ningún problema con los nombres de archivos ni carpetas, ya sea en un sistema de tipo Unix o uno de tipo Windows

-`vali_date? `: Este método valida si una fecha ingresada es válida, para esto se espera que las fechas cumplan con el formato `AAAA-MM-DD HH-II`, para de esta forma poder validar los nombres de los archivos de la clase Appointment
en caso de recibir un string cuyo tamaño es mayor a los 16 caracteres que el formato especifica, solo se utilizará los correspondientes al formato indicado

-`path`: Este método retorna la ruta desde el directorio home hasta la carpeta `.polycon`. Esto se utiliza con el fin de acortar las referencias a dicha ruta dentro de ambas clases Professional y Appointment

