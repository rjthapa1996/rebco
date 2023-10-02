import 'dart:async';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedCountryCode = "+91";
  final _formKey = GlobalKey<FormState>();

  int currentStep = 0;
  int selectedOption = 1;

  AuthController authController = AuthController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController altphoneNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  File? _selectedImage;

  get isCompleted => false;
  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Center(
          child: Column(
            children: [
              Text(
                "REPCO MICRO CREDIT COMPANY",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "Customer Information Form",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(screenSize),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps(screenSize).length - 1;
            if (isLastStep) {
                if (kDebugMode) {
                  print("Completed");
                }
            } else {
              setState(() => currentStep += 1);
            }
          },
          // onStepTapped: (step) => setState(() => currentStep = step),
          onStepCancel: currentStep == 0 ? null : () => setState(() => currentStep -= 1),
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                currentStep!=0?GestureDetector(
                  onTap: controls.onStepCancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent.shade200,
                      border: Border.all(color: Colors.black12),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                    ),
                    width: screenSize.width/4,
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: const Center(child: Text('Previous',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),)),
                  ),
                ):const SizedBox.shrink(),
                currentStep!=2?GestureDetector(
                  onTap: controls.onStepContinue,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade400,
                      border: Border.all(color: Colors.black12),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                    ),
                    width: screenSize.width/4,
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: const Center(child: Text('Next',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)),
                  ),
                ):InkWell(
                  onTap: (){
                    authController.completeRoute(context);
                  },
                  child: Container(decoration:BoxDecoration(
                            color: Colors.green.shade400,
                        border: Border.all(color: Colors.black12),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                        ) ,
                      width: screenSize.width/4,
                      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      child: const Center(child:Text("Submit",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),))),
                ),
              ],
            );
          },),
    );
  }

  List<Step> getSteps(Size screenSize) => <Step>[
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Personal Details"),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: screenSize.width/2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            buildTextField(hintText: 'Customer Name', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                              return 'Please enter valid Name';
                            }
                            return null;
                            },),
                            const SizedBox(
                              height: 20,
                            ),
                            buildTextField(hintText: 'Customer Father Name', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                              return 'Please enter valid Customer father Name';
                            }
                            return null;
                            },),
                            const SizedBox(
                              height: 20,
                            ),
                            buildTextField(hintText: 'Customer Mother Name', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                              return 'Please enter valid Customer Mother Name';
                            }
                            return null;
                            },),
                            const SizedBox(
                              height: 20,
                            ),
                            buildTextField(hintText: 'Customer Husband Name', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                              return 'Please enter valid Customer Husband Name';
                            }
                            return null;
                            },),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 12,right: 23),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                border: Border.all(color: Colors.black12),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  phoneNumberInput(
                                    controller: phoneNumberController,
                                    hintText: 'Phone Number',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter valid phone number';
                                      }
                                      if (authController.isNotValidPhone(value)) {
                                        return "Please enter valid phone number";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),

                            Container(
                              padding: const EdgeInsets.only(top: 12,right: 23),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                border: Border.all(color: Colors.black12),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  phoneNumberInput(
                                    controller: altphoneNumberController,
                                    hintText: 'Alternate Phone Number',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter valid phone number';
                                      }
                                      if (authController.isNotValidPhone(value)) {
                                        return "Please enter valid phone number";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),



                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text("Marital Status",style: TextStyle(fontSize: 17),),
                                ListTile(
                                  title: const Text('Married'),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption = value!;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text('Unmarried'),
                                  leading: Radio(
                                    value: 2,
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: _getImageFromGallery,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 100,
                                        backgroundColor: Colors.grey.shade100,
                                        backgroundImage: _selectedImage != null
                                            ? FileImage(_selectedImage!)
                                            : null,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Positioned(
                                          bottom: 2,
                                          right: 3,
                                          child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.grey.shade400,

                                              child: IconButton(
                                                  onPressed: () {
                                                    _getImageFromGallery();
                                                  },
                                                  icon: const Icon(
                                                    Icons.file_upload_outlined,
                                                    size: 15,
                                                  ),
                                                  color: Colors.black)))
                                    ], ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenSize.width/5,
                        child: GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1026),
                                lastDate: DateTime.now());
                            setState(() {
                              dobController.text = "${picked!.day} / ${picked.month} / ${picked.year}";
                            });
                          },
                          child: TextField(
                            enabled: false,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              hintText: "Date of Birth",
                              labelText: "Date of Birth",suffixStyle: const TextStyle(color: Colors.black),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_month),
                                onPressed: () {},
                              ),
                            ),
                            controller: dobController,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width/6,
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: "Age"),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width/6,
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: "Religion"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50,)
                ],
              ),
            ),
          ),
        ),


    // Professsional Details
              Step(
                state: currentStep > 1 ? StepState.complete : StepState.indexed,
                isActive: currentStep >= 1,
                title: const Text("Professional Details"),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                            buildTextField(
                              hintText: 'Customer Annual Qualification', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {return 'Please enter valid Qualification';}return null;
                        },
                        ),
                    const SizedBox(height: 20),
                    buildTextField(hintText: 'Current Occupation', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                        return 'Please enter valid Occupation';
                        }
                        return null;
                        },),
                    const SizedBox(height: 20), buildTextField(hintText: 'Customer Annual Income', keyboardType: TextInputType.number, validator: (value) {if (value.isEmpty) {
                        return 'Please enter valid Annual Income';
                        }
                        return null;
                        },),
                    const SizedBox(height: 20), buildTextField(hintText: 'Customer Address', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                        return 'Please enter valid Address';
                        }
                        return null;
                        },
                        ), const SizedBox(height: 20),
                        ],),
              ),


    //Documents
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text("Documents"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextField(hintText: 'Family Card Number', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                return 'Please enter valid Family Card Number';
              }
              return null;
              },),    const SizedBox(height: 20,),
              buildTextField(hintText: 'Voter Id Card Number', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                return 'Please enter valid Voter Id Card Number';
              }
              return null;
              },),    const SizedBox(height: 20,),
              buildTextField(hintText: 'Driving Licence Number', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                return 'Please enter valid Driving Licence Number';
              }
              return null;
              },),
              const SizedBox(height: 20,),
              buildTextField(hintText: 'Aadhaar Card Number', keyboardType: TextInputType.number, validator: (value) {if (value.isEmpty) {
                return 'Please enter valid Aadhaar Card Number';
              }
              return null;
              },),
              const SizedBox(height: 20,),
              buildTextField(hintText: 'PAN Card Number', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                return 'Please enter valid PAN Card Number';
              }
              return null;
              },),
              const SizedBox(height: 20,),
              buildTextField(hintText: 'Bank Savings Account Book Number', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                return 'Please enter valid Account Book Number';
              }
              return null;
              },),
              const SizedBox(height: 20,),
              buildTextField(hintText: 'Passport Number', keyboardType: TextInputType.text, validator: (value) {if (value.isEmpty) {
                return 'Please enter valid Passporrt Number';
              }
              return null;
              },),const SizedBox(height: 30,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                ],
              )
            ],
          ),
        ),
      ];




  buildTextField({required String hintText, required TextInputType keyboardType, required String? Function(dynamic value) validator}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
      color: Colors.grey.shade200,
      border: Border.all(color: Colors.black12),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          counterText: "",
          isCollapsed: true,
        ),
      ),
    );
  }

  phoneNumberInput({required TextEditingController controller, required String hintText, required String? Function(dynamic value) validator}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CountryCodePicker(
          showFlag: true,
          enabled: true,
          onChanged: (element) {
            selectedCountryCode = element.dialCode;
            },
          initialSelection: 'IN',
          favorite: const ['+91', 'IN'],
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          alignLeft: false,
        ),
        SizedBox(
          width: 260,
          child: TextFormField(
            validator: validator,
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              hintText: hintText,
              counterText: "",
              isCollapsed: true,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}



