import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../services/todo_service.dart';
import '../../../constants.dart';

class SearchAndFilterTodo extends StatelessWidget {
  const SearchAndFilterTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //  const Text(
        //   'Search',
        //   style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,),
        // ),
        // TextField(
        //   decoration: const InputDecoration(
        //     labelText: 'Search todos...',
        //     border: InputBorder.none,
        //     filled: true,
        //     prefixIcon: Icon(Icons.search),
        //   ),
        //   onChanged: (String? newSearchTerm) {
        //     if (newSearchTerm != null) {
        //       context
        //           .read<TodoSearchBloc>()
        //           .add(setSearchTermEvent(newSearchTerm: newSearchTerm));
        //     }
        //   },
        // ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.completed),
          ],
        ),
      ],
    );
  }

  Widget filterButton(BuildContext context, Filter filter) {
    return TextButton(
      onPressed: () {
        context
            .read<TodoFilterBloc>()
            .add(ChangeFilterEvent(newFilter: filter));
      },
      child: Text(
        filter == Filter.all
            ? 'All'
            : filter == Filter.active
            ? 'Pending'
            : 'Completed',
        style: TextStyle(
          fontSize: 18.0,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterBloc>().state.filter;
    return currentFilter == filter ? kPrimaryColor : Colors.grey;
  }
}