import 'package:crud_flutter/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewData extends StatefulWidget {
  const NewData({Key? key}) : super(key: key);
  @override
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController salary = TextEditingController();

  void addData() {
    var url = Uri.parse(
        'http://192.168.43.236/restapi_crud/create.php'); //Inserting Api Calling
    http.post(url, body: {
      "name": name.text,
      "address": address.text,
      "salary": salary.text
    }); // parameter passed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        flexibleSpace: Center(
          child: Text(
            'Tambah data karyawan',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Masukkan Nama',
                hintText: 'Masukkan Nama',
                prefixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.title),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              maxLines: 5,
              controller: address,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Masukkan ALamat',
                hintText: 'Masukkan Alamat',
                prefixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.text_snippet_outlined),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              maxLines: 5,
              controller: salary,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                labelText: 'Masukkan Gaji',
                hintText: 'Masukkan Gaji',
                prefixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.text_snippet_outlined),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius:
                  BorderRadius.circular(30), // Membuat tombol berbentuk bulat
            ),
            child: MaterialButton(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 20), // Atur ukuran tombol
              child: const Text(
                "Tambah Data",
                style: TextStyle(color: Colors.white), // Warna teks putih
              ),
              onPressed: () {
                addData();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Home()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
