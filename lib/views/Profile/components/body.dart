// ignore_for_file: must_be_immutable, prefer_function_declarations_over_variables

import 'package:chothuexemay_owner/models/owner_model.dart';
import 'package:chothuexemay_owner/utils/constants.dart';
import 'package:chothuexemay_owner/view_model/google_signin_in_view_model.dart';
import 'package:chothuexemay_owner/views/Appointment/appointment_view.dart';
import 'package:chothuexemay_owner/views/EditProfile/edit_profile.dart';
import 'package:chothuexemay_owner/views/Manage/manage_view.dart';
import 'package:chothuexemay_owner/views/Wallet/wallet_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyProfile extends StatefulWidget {
  Owner owner;
  double balance;

  BodyProfile({Key? key, required this.owner, required this.balance})
      : super(key: key);

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  //Format currency number
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]}.';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.owner.imgPath),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.owner.fullname,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "S??? ??i???n tho???i: " + widget.owner.phoneNumber,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "S??? d?? trong v??: " +
                            widget.balance
                                .toString()
                                .replaceAllMapped(reg, mathFunc) +
                            " VND",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  )
                ],
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return EditProfileView(owner: widget.owner);
                      },
                    ));
                  },
                  icon: Image.asset(
                    StringConstants.iconDirectory + "edit.png",
                    width: 25,
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        getOptionFrame("L???ch ?????t c???a t??i", () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AppointmentView();
            },
          ));
        }),
        getOptionFrame("Xe c???a t??i", () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ManageView();
            },
          ));
        }),
        getOptionFrame("V?? c???a t??i", () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const WalletView();
            },
          ));
        }),
        getOptionFrame("????ng xu???t", () {
          GoogleSignInViewModel _ggle = GoogleSignInViewModel();
          _ggle.signOut(context: context);
        }),
      ],
    );
  }

  Widget getOptionFrame(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
            Image.asset(
              StringConstants.iconDirectory + "detail.png",
              color: Colors.grey,
              width: 12,
            ),
          ],
        ),
      ),
    );
  }
}
