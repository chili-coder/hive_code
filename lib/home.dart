import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _Controller = TextEditingController();
  TextEditingController _updateController = TextEditingController();
  Box ?nameBox;
  @override
  void initState() {
    // TODO: implement initState
    nameBox= Hive.box("name-list");
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 16,right: 16,bottom: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _Controller,

                validator: (value){
                  if(value!.isEmpty){
                    return "Required";
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                  hintText: 'Name',

                ),
              ),



              SizedBox(height: 30,),
              RaisedButton.icon(
                onPressed: (){

                  print('Data Save');
                  if (_formKey.currentState!.validate()) {
                    var userInput = _Controller.text;
                    nameBox!.add(userInput);
                    _Controller.clear();
                    //print("Successful");
                  } else {
                    print("Something wrong");
                  }
                  //Navigator.push(context, MaterialPageRoute(builder: (context) =>NavigationDrawer()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                label: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 50,top: 10,bottom: 10),
                  child: Text("Save"),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 50,right: 10,top: 10,bottom: 10),
                  child: Icon(Icons.save,),
                ),
                textColor: Colors.white,
                splashColor: Colors.red,
                color: Colors.lightBlue,
              ),


              SizedBox(height: 40,),

              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: Hive.box("name-list").listenable(),
                    builder: (context,box,widget){
                      return ListView.builder(
                          itemCount: nameBox!.keys.toList().length,
                          itemBuilder: (context,index){
                            return Card(
                              child: ListTile(
                                title: Text(nameBox!.getAt(index).toString()),

                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: (){


                                          showDialog(context: context, builder: (context){
                                            return Column(
                                              children: [
                                                AlertDialog(
                                                  title: Text("Update Name",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                                                  content: Column(
                                                    children: [
                                                      SizedBox(height: 20,),
                                                      TextFormField(
                                                        controller: _updateController,

                                                        validator: (value){
                                                          if (value!.isEmpty) {
                                                            return "Required";
                                                          }

                                                        },
                                                        decoration: InputDecoration(
                                                          isDense: true,
                                                          filled: true,
                                                          border: OutlineInputBorder(),
                                                          labelText: 'Name',
                                                          labelStyle: TextStyle(color: Colors.blueAccent,),
                                                          hintText: 'Name',
                                                          // helperText: 'help',
                                                          // counterText: 'counter',
                                                          prefixIcon: Icon(Icons.person,color:Colors.blueAccent ,),
                                                        ),
                                                      ),

                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 30),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        RaisedButton.icon(
                                                          onPressed: (){
                                                            setState(() {
                                                              Navigator.pop(context);
                                                            });

                                                          },
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(30))),
                                                          label: Padding(
                                                            padding: const EdgeInsets.only(top: 8,bottom: 8),
                                                            child: Text('Cancel', style: GoogleFonts.poppins(textStyle: TextStyle( color: Colors.white, letterSpacing: .5),),),
                                                          ),
                                                          icon: Icon(Icons.cancel_outlined, color:Colors.white,),
                                                          textColor: Colors.white,
                                                          splashColor: Colors.red,
                                                          color: Colors.blueAccent,
                                                        ),
                                                        SizedBox(width: 20,),

                                                        RaisedButton.icon(
                                                          onPressed: (){
                                                            nameBox!.putAt(index, _updateController.text);
                                                            _updateController.clear();

                                                          },
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(30))),
                                                          label: Padding(
                                                            padding: const EdgeInsets.only(top: 8,bottom: 8),
                                                            child: Text('Update', style: GoogleFonts.poppins(textStyle: TextStyle( color: Colors.white, letterSpacing: .5),),),
                                                          ),
                                                          icon: Icon(Icons.add, color:Colors.white,),
                                                          textColor: Colors.white,
                                                          splashColor: Colors.green,
                                                          color: Colors.lightBlue,
                                                        ),
                                                      ],
                                                    ),
                                                  )

                                                    ],
                                                  ),




                                                ),
                                              ],
                                            );
                                          });


                                        },
                                        icon: Icon(Icons.edit),
                                      ),



                                      IconButton(
                                        onPressed: (){
                                          nameBox!.deleteAt(index);
                                        },
                                        icon: Icon(Icons.delete,color: Colors.red,),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              )

            ],
          ),
        ),
      ),
    );
  }
}
