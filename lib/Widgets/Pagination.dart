import 'package:flutter/material.dart';
class Pagination extends StatefulWidget {
  const Pagination({
    Key? key,
    required this.initPageSelected,
  }) : super(key: key);

  final int? initPageSelected;

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
       /*  for (var index = 0;
            index <= context.read<AppointmentCubit>().state.maxPageNumber;
            index++)
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: InkWell(
              onTap: () {
                 setState(() {
                  initPageSelected = index;
                }); 

                /   context.read<AppointmentCubit>().setNextPage(
                    nextPage: index,
                    token: context.read<LoginCubit>().state.homeToken,
                    searchParams: context
                        .read<AppointmentCubit>()
                        .state
                        .searchParams); 
              },
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: widget.initPageSelected == index
                          ? const Color.fromARGB(255, 56, 155, 152)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                    "${index + 1}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: widget.initPageSelected == index
                            ? Colors.white
                            : const Color.fromARGB(255, 56, 155, 152)),
                  ))),
            ),
          ) */
      ],
    );
  }
}



//need nextpage
//the method
