import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crud_flutter/edit.dart';
import 'package:crud_flutter/main.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  final List list; // Tambahkan kata kunci 'final' di sini
  final int index; // Tambahkan kata kunci 'final' di sini
  Details({required this.list, required this.index});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void delete() {
    var url = Uri.parse(
        'http://192.168.43.236/restapi_crud/delete.php'); //deletion api
    http.post(url, body: {'id': widget.list[widget.index]['id']});
  }

  void confirm() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Kamu Yakin?"), //confirming the deletion of record
      actions: [
        MaterialButton(
          child: const Text("YA HAPUS"),
          onPressed: () {
            delete();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => Home()));
          },
        ),
        MaterialButton(
          child: const Text("TIDAK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
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
            'Detail Karyawan '
            '${widget.list[widget.index]['name']}',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 20.0), // Atur margin kiri dan kanan
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0), // Atur margin kanan dan kiri di sini
                    child: Align(
                      alignment: Alignment.center, // Meletakkan teks di tengah
                      child: Text(
                        widget.list[widget.index]['name'],
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Alamat: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.list[widget.index]['address']),
                  const SizedBox(height: 10),
                  Text(
                    'Gaji: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _formatCurrency(widget.list[widget.index]['salary']),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: const Text(
                        "Edit Data",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Edit(list: widget.list, index: widget.index),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        confirm();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatCurrency(dynamic amount) {
  if (amount is int) {
    return 'Rp ${amount.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match match) => '${match[1]},',
            )}'
        .trim();
  } else if (amount is String) {
    int intValue = int.tryParse(amount) ?? 0;
    return 'Rp ${intValue.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match match) => '${match[1]},',
            )}'
        .trim();
  } else {
    return 'Rp 0';
  }
}
