// ignore_for_file: prefer_function_declarations_over_variables, deprecated_member_use

import 'package:chothuexemay_owner/models/order_model.dart';
import 'package:chothuexemay_owner/utils/constants.dart';
import 'package:chothuexemay_owner/view_model/owner_view_model.dart';
import 'package:chothuexemay_owner/views/Home/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BodyRequestHandling extends StatefulWidget {
  OrderModel order;

  BodyRequestHandling({Key? key, required this.order}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BodyRequestHandling();
  }
}

class _BodyRequestHandling extends State<BodyRequestHandling> {
  final OwnerViewModel _ownerViewModel = OwnerViewModel();

  //Format currency number
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]}.';

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    DateTime dateRent = dateFormat.parse(widget.order.dateRent);
    DateTime dateReturn = dateFormat.parse(widget.order.dateReturn);
    String txtDateRent = dateRent.day.toString() +
        "/" +
        dateRent.month.toString() +
        "/" +
        dateRent.year.toString() +
        " - " +
        dateRent.hour.toString() +
        ":" +
        dateRent.minute.toString();
    String txtDateReturn = dateReturn.day.toString() +
        "/" +
        dateReturn.month.toString() +
        "/" +
        dateReturn.year.toString() +
        " - " +
        dateReturn.hour.toString() +
        ":" +
        dateReturn.minute.toString();
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Xe ???????c ch???n",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: ColorConstants.textBold),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.order.licensePlate,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Image.asset(StringConstants.iconDirectory + "point.png"),
                    Text(
                      widget.order.bikeName,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Image.network(
                widget.order.bikeImage,
                width: size.width * 0.5,
                height: size.width * 0.4,
                fit: BoxFit.fill,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black, width: 1))),
                  ),
                  const Text(
                    "Th??ng tin kh??ch h??ng",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 50,
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black, width: 1))),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "T??n:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Ng??y thu??:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Ng??y tr???:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.order.customerName,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              txtDateRent,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              txtDateReturn,
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      "?????a ch??? nh???n xe:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.order.address,
                      style: const TextStyle(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                StringConstants.iconDirectory + "price.png",
                width: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.order.price
                        .round()
                        .toString()
                        .replaceAllMapped(reg, mathFunc) +
                    " vn??",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 45,
                  width: size.width * 0.46,
                  child: RaisedButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.redAccent,
                    onPressed: () {
                      _ownerViewModel.denyOrder(widget.order.customerId!);
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return const HomeView();
                      }), (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      "T??? CH???I",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  )),
              SizedBox(
                  height: 45,
                  width: size.width * 0.46,
                  child: RaisedButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: ColorConstants.background,
                    onPressed: () {
                      _ownerViewModel.acceptOrder(widget.order.customerId!);
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return const HomeView();
                      }), (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      "CH???P NH???N",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
