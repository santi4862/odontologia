function fecha() {
    var lista = document.getElementById("day");
    var lista1 = document.getElementById("year");
    var today = new Date();
    var año = today.getFullYear();
    for (i = 1; i < 32; i++) {
        lista.options.add(new Option(i, i));
    }
    for (i = 0; i < 150; i++) {
        lista1.options.add(new Option(año, año));
        año--;
    }

}
function enviar(codigos, ids) {
    opener.document.forms['ncitas'].elements['busqueda'].value = codigos;
    opener.document.forms['ncitas'].elements['idp'].value = ids;
    self.close();
}
function pasar(espe) {

    opener.document.forms['registro'].elements['especialidad'].value = espe;
    self.close();
}
function evaluar(forme)
{

    var t = document.getElementById("tdocumento").value;
    if (t == "true") {
        var a = document.getElementById("dni").value;
        if (a.length == 10) {
            var cedula = a;
//Obtenemos el digito de la region que sonlos dos primeros digitos
            var digito_region = cedula.substring(0, 2);
//Pregunto si la region existe ecuador se divide en 24 regiones
            if (digito_region >= 1 && digito_region <= 24) {
// Extraigo el ultimo digito
                var ultimo_digito = cedula.substring(9, 10);

//Agrupo todos los pares y los sumo
                var pares = parseInt(cedula.substring(1, 2)) + parseInt(cedula.substring(3, 4)) + parseInt(cedula.substring(5, 6)) + parseInt(cedula.substring(7, 8));

//Agrupo los impares, los multiplico por un factor de 2, si la resultante es > que 9 le restamos el 9 a la resultante
                var numero1 = cedula.substring(0, 1);
                var numero1 = (numero1 * 2);
                if (numero1 > 9) {
                    var numero1 = (numero1 - 9);
                }

                var numero3 = cedula.substring(2, 3);
                var numero3 = (numero3 * 2);
                if (numero3 > 9) {
                    var numero3 = (numero3 - 9);
                }

                var numero5 = cedula.substring(4, 5);
                var numero5 = (numero5 * 2);
                if (numero5 > 9) {
                    var numero5 = (numero5 - 9);
                }

                var numero7 = cedula.substring(6, 7);
                var numero7 = (numero7 * 2);
                if (numero7 > 9) {
                    var numero7 = (numero7 - 9);
                }

                var numero9 = cedula.substring(8, 9);
                var numero9 = (numero9 * 2);
                if (numero9 > 9) {
                    var numero9 = (numero9 - 9);
                }

                var impares = numero1 + numero3 + numero5 + numero7 + numero9;

//Suma total
                var suma_total = (pares + impares);

//extraemos el primero digito
                var primer_digito_suma = String(suma_total).substring(0, 1);

//Obtenemos la decena inmediata
                var decena = (parseInt(primer_digito_suma) + 1) * 10;

//Obtenemos la resta de la decena inmediata - la suma_total esto nos da el digito validador
                var digito_validador = decena - suma_total;

//Si el digito validador es = a 10 toma el valor de 0
                if (digito_validador == 10)
                    var digito_validador = 0;

//Validamos que el digito validador sea igual al de la cedula
                if (digito_validador == ultimo_digito) {
                } else {
                    sweetAlert("Información del Sistema", "Cedula:" + cedula + " invalida", "warning");
                    forme.dni.value = "";
                }
            }
        }
        else
        {
            forme.dni.value = "";
        }
    }
}
function validare(forme) {
    var email = document.getElementById("correo").value;
    expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    if (!expr.test(email)) {
        sweetAlert("Información del Sistema", "Correo " + email + " Invalido", "warning");
        forme.correo.value = "";
    }
}

function letras(e) { // 1
    tecla = (document.all) ? e.keyCode : e.which;
    if (tecla == 8)
        return true; // backspace
    if (tecla == 32)
        return true; // espacio
    if (e.ctrlKey && tecla == 86) {
        return true;
    } //Ctrl v
    if (e.ctrlKey && tecla == 67) {
        return true;
    } //Ctrl c
    if (e.ctrlKey && tecla == 88) {
        return true;
    } //Ctrl x

    patron = /[a-zA-Z]/; //patron

    te = String.fromCharCode(tecla);
    return patron.test(te); // prueba de patron
}

function numeros(e) { // 1
    tecla = (document.all) ? e.keyCode : e.which; // 2
    if (tecla == 8)
        return true; // backspace
    if (tecla == 109)
        return true; // menos
    if (tecla == 110)
        return true; // punto
    if (tecla == 110)
        return true; // punto
    if (tecla == 110)
        return true; // punto
    if (tecla == 189)
        return true; // guion
    if (e.ctrlKey && tecla == 86) {
        return true
    }
    ; //Ctrl v
    if (e.ctrlKey && tecla == 67) {
        return true
    }
    ; //Ctrl c
    if (e.ctrlKey && tecla == 88) {
        return true
    }
    ; //Ctrl x
    if (tecla >= 96 && tecla <= 105) {
        return true;
    } //numpad

    patron = /[0-9]/; // patron

    te = String.fromCharCode(tecla);
    return patron.test(te); // prueba
}
function validarp(tx, forme)
{
    var nMay = 0, nMin = 0, nNum = 0, nEsp = 0;
    var t1 = "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ"
    var t2 = "abcdefghijklmnñopqrstuvwxyz"
    var t3 = "0123456789"
    var t4 = "°!#$%&/()='¿?¡+*-{}[]"
    if (tx.length < 8) {
        sweetAlert("Información del Sistema", "Su password, debe tener al menos 8 caracteres", "warning");
        forme.clave.value = "";
    }
    else
    {
        for (i = 0; i < tx.length; i++) {
            if (t1.indexOf(tx.charAt(i)) != -1) {
                nMay++;
            }
            if (t2.indexOf(tx.charAt(i)) != -1) {
                nMin++;
            }
            if (t3.indexOf(tx.charAt(i)) != -1) {
                nNum++;
            }
            if (t4.indexOf(tx.charAt(i)) != -1) {
                nEsp++;
            }
        }
        if (nMay > 0 && nMin > 0 && nNum > 0 && nEsp > 0) {

            return true;
        }
        else {
            sweetAlert("Información del Sistema", "* La longitud debe tener mínimo 8 caracteres. \n\
* Debe contener al menos 1 número. \n\
* Debe contener al menos 1 caracter alfabético en mayúscula y 1 en minúscula. \n\
* Debe contener al menos 1 caracter especial.", "warning");
            forme.clave.value = "";
            return false;
        }
    }

}

function abrirc(formulario)
{
    var f = formulario + ".jsp";
    mywindow = window.open(f, "Buscador de datos", "location=1,status=1,scrollbars=1,  width=800,height=700");
    mywindow.moveTo(100, 100);
}


function imprimird(nombre)
{
    var ficha = document.getElementById(nombre);
    var ventimp = window.open(' ', 'popimpr');
    ventimp.document.write(ficha.innerHTML);
    ventimp.document.close();
    ventimp.print( );
    ventimp.close();
}
