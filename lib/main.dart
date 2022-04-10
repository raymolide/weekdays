import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.yellow[700],
          textTheme:
              TextTheme(bodyText2: TextStyle(color: Colors.yellow[700])))));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime inicio = new DateTime.now();
  DateTime fim = DateTime.now();
  int diasUteis = 0;
  int fds = 0;

  int diasUteisCalc(DateTime inicio, DateTime fim) {
    int diasUteis = 0;
    for (var dataI = inicio;
        fim.difference(dataI).inDays >= 0;
        dataI = dataI.add(Duration(days: 1))) {
      if (dataI.weekday == 6 || dataI.weekday == 7) {
        continue;
      }
      diasUteis++;
    }
    return diasUteis;
  }

  int fdsCalc(DateTime inicio, DateTime fim) {
    int fds = 0;
    for (var dataI = inicio;
        fim.difference(dataI).inDays >= 0;
        dataI = dataI.add(Duration(days: 1))) {
      if (dataI.weekday == 6) {
        fds++;
      }
    }
    return fds;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Contador de Dias Uteis",
            style: GoogleFonts.ubuntu(fontSize: 18, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.yellow[700],
        ),
        body: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.calendar_today,
                      size: size.width * .2, color: Colors.yellow[700]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 50,
                      width: size.width * .40,
                      child: DateTimePicker(
                        style: TextStyle(color: Colors.yellow[700]),
                        decoration: InputDecoration(
                          labelText: "Digite a data de inicio",
                          icon: Icon(Icons.calendar_today_sharp,
                              color: Colors.yellow[700]),
                        ),
                        initialValue: "Digite a data de inicio",
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Data Inicio',
                        onChanged: (val) {
                          setState(() {
                            inicio = DateFormat("yyyy-MM-dd").parse(val);
                            diasUteis = diasUteisCalc(inicio, fim);
                            fds = fdsCalc(inicio, fim);
                          });
                        },
                        validator: (val) {
                          if (val != null) {
                            return "A data de inicio é maior que a data fim";
                          }
                        },
                        onSaved: (val) => print(val),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 50,
                      width: size.width * .40,
                      child: DateTimePicker(
                        style: TextStyle(color: Colors.yellow[700]),
                        decoration: InputDecoration(
                          labelText: "Digite a data de fim",
                          icon: Icon(Icons.calendar_today_sharp,
                              color: Colors.yellow[700]),
                        ),
                        initialValue: fim.toString(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Data Fim',
                        onChanged: (val) {
                          setState(() {
                            fim = DateFormat("yyyy-MM-dd").parse(val);
                            diasUteis = diasUteisCalc(inicio, fim);
                            fds = fdsCalc(inicio, fim);
                          });
                        },
                      )),
                ),
                Text(
                  "Existem $diasUteis dias uteis no intervalo definido",
                  style: GoogleFonts.ubuntu(fontSize: 18),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  "Existem $fds finais de semana no intervalo definido",
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ));
  }
}
