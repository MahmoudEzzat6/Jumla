import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextField({
  required TextEditingController? controller,textColor,
  TextInputType? type,
  Function()? onTap,
  Color? color,
  Function(String)? onChange,
  required String? Function(String?) validate,
  Function(String)? onSubmit,
  bool isPassword = false,
  required String? label,
  required IconData? prefix,colors,
  IconData? suffix,colo,
  Function()? suffixPress, ListView? child,
}) {
  return TextFormField(
    style: TextStyle(color: color),
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onChanged: onChange,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    validator: validate,
    decoration: InputDecoration(
      errorStyle: TextStyle(color: Colors.lightBlueAccent),
      labelStyle: TextStyle(color: color),
      labelText: label,
      prefixIcon: Icon(prefix,color: color,),
      suffixIcon: suffix != null
          ? IconButton(onPressed: suffixPress, icon: Icon(suffix,color: color,))
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color? background,
  Color? textColor,
  bool isUpper = true,
  required VoidCallback onTap,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
          color: background,
        borderRadius: BorderRadius.circular(20)
      ),
      width: width,
     // color: background,
      child: MaterialButton(
        onPressed: onTap,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

void navigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigateAndFinish (context,widget) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
}
void toastShow(String msg,ToastStates state) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: toastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates { Success, Error, WARNING }


Color? toastColor(ToastStates state){
  Color? color;
  switch (state){
    case ToastStates.Success:
      color=Colors.green;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
    case ToastStates.Error:
      color=Colors.red;
      break;
        }
  return color;
}
void printFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
Widget buildListItem( model, BuildContext context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 135.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
                image: NetworkImage('${model.image}'),
                fit: BoxFit.contain,
                width: 120.0,
                height: 120.0,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Image(
                    image: NetworkImage(
                        'assets/images/error.png'),
                  );
                }),
            if (model.discount != 0 && model.discount!=null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.redAccent,
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price} EG',
                      style:
                      TextStyle(fontSize: 14.0, color: Colors.blue),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != null && model.discount!=0)
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget imageError()=>Image(
  image: AssetImage(
      'assets/images/error.png'),
);
