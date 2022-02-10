import 'package:cafe_mostbyte/bloc/form_submission_status.dart';
import 'package:cafe_mostbyte/bloc/moderator_expense/moderator_expense_bloc.dart';
import 'package:cafe_mostbyte/bloc/moderator_expense/moderator_expense_event.dart';
import 'package:cafe_mostbyte/bloc/moderator_expense/moderator_expense_repository.dart';
import 'package:cafe_mostbyte/bloc/moderator_expense/moderator_expense_state.dart';
import 'package:cafe_mostbyte/components/moderator/moderator_expense_card.dart';
import 'package:cafe_mostbyte/components/moderator/moderator_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/globals.dart' as globals;

_ModeratorHeadState moderatorHeaderState = _ModeratorHeadState();

class ModeratorHead extends StatefulWidget {
  ModeratorHead({Key? key}) : super(key: key);

  @override
  _ModeratorHeadState createState() {
    moderatorHeaderState = _ModeratorHeadState();
    return moderatorHeaderState;
  }
}

class _ModeratorHeadState extends State<ModeratorHead> {
  ScrollController tabScroll = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: 0,
      child: RepositoryProvider(
        create: (context) => ModeratorExpenseRepository(),
        child: BlocProvider(
          create: (context) => ModeratorExpenseBloc(
              repo: context.read<ModeratorExpenseRepository>()),
          child: BlocListener<ModeratorExpenseBloc, ModeratorExpenseState>(
            listener: (context, state) {
              var formStatus = state.formStatus;
              if (formStatus is SubmissionSuccess) {
                moderatorExpenseCardPageState.setState(() {});
                moderatorFooterPageState.setState(() {});
                context
                    .read<ModeratorExpenseBloc>()
                    .add(ModeratorExpenseInitialized());
              } else if (formStatus is SubmissionFailed) {}
              // TODO: implement listener
            },
            child: Container(
              width: dWidth * 0.93,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<ModeratorExpenseBloc, ModeratorExpenseState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          context
                              .read<ModeratorExpenseBloc>()
                              .add(ModeratorExpenseCreate());
                        },
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                          )),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
