import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/RegisterScreen.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {

   LoginScreen({Key? key}) : super(key: key);
   var emailController   =TextEditingController();
   var passwordController=TextEditingController();
   var formKey           = GlobalKey<FormState>();//to validate on the text form field.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){
                if(state.loginModel.status == true){
                  //here you can go to home screen.
                  //status true.
                  CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token)
                      .then((value) => navigateAndFinish(context,const ShopLayout()));
                }else{
                  //show the message in a toast.
                  //status false.
                  makeToast(message: state.loginModel.message.toString(),toastState: ToastStates.ERROR);
                }
          }
        },
        builder: (context, state) => Scaffold(
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
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey
                        ),

                      ),
                      const SizedBox(height: 40.0),
                      DefaultTextFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validator: (string) {
                            if(string!.isEmpty){
                              return 'please enter the email';
                            }
                            return null;
                          },
                          label: 'Email',
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
                        onFieldSubmitted: (string) {
                          //validate to login the user.
                          if(formKey.currentState!.validate()){
                            LoginCubit.get(context).loginUser(
                              email: emailController.text,
                              password:passwordController.text,
                            );
                          }
                        },
                        isPassword: LoginCubit.get(context).isPassword,
                        suffix:IconButton(
                            icon:Icon(LoginCubit.get(context).suffix) ,
                            onPressed: () {
                                LoginCubit.get(context).changePasswordVisibility();
                            },
                            ),
                      ),
                      const SizedBox(height: 16.0),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,

                        builder:(context) => DefaultButton(
                            function:(){
                              //validate to login the user.
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).loginUser(
                                  email: emailController.text,
                                  password:passwordController.text,
                                );
                              }

                            },
                            text: 'LOGIN'
                        ),//DefaultButton
                        fallback:(context) =>const Center(child: CircularProgressIndicator()) ,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            child:const Text('register') ,
                            onPressed: () {
                              navigateTo(context,const RegisterScreen());
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
        ) ,
      ),
    );
  }
}
