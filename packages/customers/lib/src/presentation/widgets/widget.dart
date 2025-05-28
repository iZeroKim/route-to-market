import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/get_customers_state_cubit.dart';
import '../../domain/entities/customer.dart';

class CustomersDropdown extends StatelessWidget {
  final void Function(Customer? selected)? onChanged;

  const CustomersDropdown({
    super.key,
    this.onChanged,
  });
  Widget _buildListItem(BuildContext context, Customer customer, bool isLoading, VoidCallback isSelected) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(' ${customer.id} ${customer.name}' ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        final isLoading = state is CustomersLoading;
        final customers = state is CustomersLoaded ? state.customers : <Customer>[];

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
                    'Customer',
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
            CustomDropdown<Customer>.search(
              hintText: 'Select customer',
              items: customers,
              // initialItem: customers.first,
              decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(8),
                  closedBorder: Border.all(
                    color: Colors.grey,
                  ),
                  listItemStyle: const TextStyle(fontSize: 13),
                  hintStyle: const TextStyle(fontSize: 13, color: Colors.black),
                  headerStyle: const TextStyle(
                    fontSize: 13,
                  )),
              listItemBuilder: (_, customer, isLoading, isSelected ) => _buildListItem(context, customer, false, isSelected),
              headerBuilder: (_, customer, isLoading ) {
                return Text(
                  customer.name,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                );
              },
              listItemPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              closedHeaderPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              onChanged: onChanged,
            ),
          ],
        );
      },
    );
  }
}
