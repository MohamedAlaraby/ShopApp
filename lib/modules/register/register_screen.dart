import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/constants.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
  var emailController   =TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  var formKey           = GlobalKey<FormState>();//to validate on the text form field.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context, state) {
            if(state is RegisterSuccessState){
              if(state.registerModel.status == true){
                //here you can go to home screen.
                //status true.
                CacheHelper.saveData(key: 'token', value: state.registerModel.data?.token)
                    .then((value) {
                  navigateAndFinish(context, LoginScreen());
                  token=CacheHelper.getData(key: 'token');
                  print('your token is $token');
                } );

              }else{
                //show the message in a toast.
                //status false.
                makeToast(message: state.registerModel.message.toString(),toastState: ToastStates.ERROR);
              }
            }
          },
           builder: (context, state) {
            var cubit=RegisterCubit.get(context);
            return Scaffold(
              appBar:AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'REGISTER',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.black
                            ),
                          ),
                          Text(
                            'Register now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey
                            ),

                          ),
                          const SizedBox(height: 40.0),
                          DefaultTextFormField(
                              controller: nameController,
                              textInputType: TextInputType.name,
                              validator: (string) {
                                if(string!.isEmpty){
                                  return 'please enter the name';
                                }
                                return null;
                              },
                              label: 'Name',
                              prefix: Icons.person
                          ),
                          const SizedBox(height: 16.0),
                          DefaultTextFormField(
                              controller: emailController,
                              textInputType: TextInputType.emailAddress,
                              validator: (string) {
                                if(string!.isEmpty){
                                  return 'please enter the email';
                                }
                                return null;
                              },
                              label: 'Email Address',
                              prefix: Icons.email
                          ),
                          const SizedBox(height: 16.0),
                          DefaultTextFormField(
                            controller: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            validator: (string) {
                              if(string!.isEmpty){
                                return 'please enter the password';
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: Icons.lock,
                            isPassword: cubit.isPassword,
                            suffix:IconButton(
                              icon:Icon(cubit.suffix) ,
                              onPressed: () {
                                cubit.changePasswordVisibility();
                              },
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          DefaultTextFormField(
                              controller: phoneController,
                              textInputType: TextInputType.phone,
                              validator: (string){
                                if(string!.isEmpty){
                                  return 'please enter the phone';
                                }
                                return null;
                              },
                              label: 'Phone',
                              prefix: Icons.phone
                          ),
                          const SizedBox(height: 16.0),


                          ConditionalBuilder(
                            condition:state is! RegisterLoadingState,
                            builder:(context) => DefaultButton(
                                function:(){
                                  //validate to register the user.
                                  if(formKey.currentState!.validate()){
                                      RegisterCubit.get(context).registerUser(
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      email: emailController.text,
                                      password:passwordController.text,
                                    );
                                  }
                                },
                                text: 'REGISTER'
                            ),//DefaultButton
                            fallback:(context) =>const Center(child: CircularProgressIndicator()) ,
                          ),
                          const SizedBox(height: 16.0),





                          Row(
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                child:const Text('Login') ,
                                onPressed: () {
                                  navigateTo(context,LoginScreen());
                                },
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );

           },
        ),
      );

  }
}
