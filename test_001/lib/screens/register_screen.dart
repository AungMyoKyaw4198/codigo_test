import 'package:flutter/material.dart';
import 'package:test_001/utils/assets.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstName = TextEditingController();

  final TextEditingController _lastName = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _dateOfBirth = TextEditingController();
  final TextEditingController _nationality = TextEditingController();
  final TextEditingController _countryResidence = TextEditingController();
  final TextEditingController _mobile = TextEditingController();

  bool isFemale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  // Title
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 150, bottom: 20, top: 30),
                    color: Colors.grey[200],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Almost there!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Complete the form below to create your Ready To Travel account.',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '*Mandatory',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),

                  // Form
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            TextFormField(
                              controller: _firstName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter firstname';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text(
                                  'First Name*',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _lastName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter lastname';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text(
                                  'Last Name*',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _email,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email';
                                } else if (!value.contains('@')) {
                                  return 'Please enter valid email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text(
                                  'Email Address*',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: TextFormField(
                                    controller: _dateOfBirth,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900, 1, 1),
                                              lastDate: DateTime.now())
                                          .then((value) {
                                        if (value != null) {
                                          _dateOfBirth.text =
                                              '${value.day} / ${value.month} / ${value.year}';
                                        }
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter date of birth';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        label: const Text(
                                          'Date of Birth*',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        suffixIcon: Image.asset(CAKE_LOGO)),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(40))),
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isFemale = !isFemale;
                                            });
                                          },
                                          child: isFemale
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.green,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  30))),
                                                  child: const Text('Female'),
                                                )
                                              : const Text('Female')),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isFemale = !isFemale;
                                            });
                                          },
                                          child: !isFemale
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.green,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  30))),
                                                  child: const Text('Male'),
                                                )
                                              : const Text('Male')),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            TextFormField(
                              controller: _nationality,
                              onTap: () {},
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter nationality';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text(
                                  'Nationality*',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _countryResidence,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter country of residence';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text(
                                  'Country of Residence*',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: _mobile,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                bool isNumeric(String s) {
                                  if (s == null) {
                                    return false;
                                  }
                                  return double.tryParse(s) != null;
                                }

                                if (!isNumeric(value!)) {
                                  return 'Please enter correct phone number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  label: const Text(
                                    'Mobile no.(Optional)',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  prefix: Container(
                                    child: const Text('+65'),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0.0, 1.0],
                                    colors: [
                                      Color(0xFF17A0B8),
                                      Color(0xff17a0d6),
                                    ],
                                  ),
                                  color: const Color(0xFF17A0B8)),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    shadowColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.pushNamed(context, '/main');
                                    }
                                  },
                                  child: const Center(
                                      child: Text(
                                    'Create a new account',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                  left: 10,
                  top: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/welcome');
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  )),
              Positioned(
                right: 30,
                top: 60,
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 85,
                    // ),
                    Image.asset(
                      GUITAR_IMAGE,
                      scale: 1.2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
