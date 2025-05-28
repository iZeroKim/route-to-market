import 'package:activities/src/domain/entities/activity.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/activities_state_cubit.dart';


class ActivitiesDropdown extends StatelessWidget {
  final void Function(Activity? selected)? onChanged;

  const ActivitiesDropdown({
    super.key,
    this.onChanged,
  });
  Widget _buildListItem(BuildContext context, Activity activity, bool isLoading, VoidCallback isSelected) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(' ${activity.id} ${activity.description}' ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      builder: (context, state) {
        final isLoading = state is ActivitiesLoading;
        final activities = state is ActivitiesLoaded ? state.activities : <Activity>[];

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4, left: 2, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Activities',
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                  if (isLoading)
                    SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.grey.withOpacity(0.8),
                        strokeWidth: 1,
                      ),
                    )
                ],
              ),
            ),
            CustomDropdown<Activity>.multiSelectSearch(
              hintText: 'Select customer',
              items: activities,
              // initialItem: Activities.first,
              decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(8),
                  closedBorder: Border.all(
                    color: Colors.grey,
                  ),
                  closedFillColor: Colors.transparent,
                  expandedFillColor: Colors.white,
                  expandedBorderRadius: BorderRadius.circular(8),
                  expandedBorder: Border.all(
                    color: Colors.grey,
                  ),
                  listItemStyle: const TextStyle(fontSize: 13),
                  hintStyle: const TextStyle(fontSize: 13, color: Colors.black),
                  headerStyle: const TextStyle(
                    fontSize: 13,
                  )),
              listItemBuilder: (_, activity, isLoading, isSelected ) => _buildListItem(context, activity, false, isSelected),
              listItemPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              closedHeaderPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
             onListChanged: (List<Activity> items ) {  },
            ),
          ],
        );
      },
    );
  }
}
