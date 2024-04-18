part of '../country_info_picker.dart';

class CountryInfoPicker extends StatefulWidget {
  final ValueChanged<CountryInfoModel>? onChanged;
  final ValueChanged<CountryInfoModel?>? onInit;
  final String? initialSelection;
  final List<String> favorite;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? dialogTextStyle;
  final WidgetBuilder? emptySearchBuilder;
  final Function(CountryInfoModel?)? builder;
  final bool enabled;
  final TextOverflow textOverflow;
  final Icon closeIcon;

  /// Barrier color of ModalBottomSheet
  final Color? barrierColor;

  /// Background color of ModalBottomSheet
  final Color? backgroundColor;

  /// BoxDecoration for dialog
  final BoxDecoration? boxDecoration;

  /// the size of the selection dialog
  final Size? dialogSize;

  /// Background color of selection dialog
  final Color? dialogBackgroundColor;

  /// used to customize the country list
  final List<String>? countryFilter;

  /// shows the name of the country instead of the dialcode
  final bool showOnlyCountryWhenClosed;

  /// aligns the flag and the Text left
  ///
  /// additionally this option also fills the available space of the widget.
  /// this is especially useful in combination with [showOnlyCountryWhenClosed],
  /// because longer country names are displayed in one line
  final bool alignLeft;

  /// shows the flag
  final bool showFlag;

  final bool hideMainText;

  final bool? showFlagMain;

  final bool? showFlagDialog;

  /// Width of the flag images
  final double flagWidth;

  /// Use this property to change the order of the options
  final Comparator<CountryInfoModel>? comparator;

  /// Set to true if you want to hide the search part
  final bool hideSearch;

  /// Set to true if you want to show drop down button
  final bool showDropDownButton;

  /// [BoxDecoration] for the flag image
  final Decoration? flagDecoration;

  /// An optional argument for injecting a list of countries
  /// with customized codes.
  final List<Map<String, dynamic>> countryList;

  // Boolean value to show the Dialog or Page for selection
  // With Default value as [true]
  final bool showPage;

  // Widget to show the suffix icon
  final Widget? suffixIcon;

  // [CountryPickerType] to show the Dialog or Page for selection
  final CountryPickerType countryPickerType;
  final FloatingLabelAlignment? floatingLabelAlignment;
  const CountryInfoPicker({
    this.onChanged,
    this.onInit,
    this.initialSelection,
    this.favorite = const [],
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.searchDecoration = const InputDecoration(),
    this.searchStyle,
    this.dialogTextStyle,
    this.emptySearchBuilder,
    this.showOnlyCountryWhenClosed = false,
    this.alignLeft = false,
    this.showFlag = true,
    this.showFlagDialog,
    this.hideMainText = false,
    this.showFlagMain,
    this.flagDecoration,
    this.builder,
    this.flagWidth = 32.0,
    this.enabled = true,
    this.textOverflow = TextOverflow.ellipsis,
    this.barrierColor,
    this.backgroundColor,
    this.boxDecoration,
    this.comparator,
    this.countryFilter,
    this.hideSearch = false,
    this.showDropDownButton = false,
    this.dialogSize,
    this.dialogBackgroundColor,
    this.closeIcon = const Icon(Icons.close),
    this.countryList = codes,
    this.showPage = true,
    this.countryPickerType = CountryPickerType.DialCodeAndCountryCode,
    this.floatingLabelAlignment = FloatingLabelAlignment.center,
    this.suffixIcon,
    Key? key,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    List<Map<String, dynamic>> jsonList = countryList;

    List<CountryInfoModel> elements =
        jsonList.map((json) => CountryInfoModel.fromJson(json)).toList();

    if (comparator != null) {
      elements.sort(comparator);
    }

    if (countryFilter != null && countryFilter!.isNotEmpty) {
      final uppercaseCustomList =
          countryFilter!.map((criteria) => criteria.toUpperCase()).toList();
      elements = elements
          .where((criteria) =>
              uppercaseCustomList.contains(criteria.code) ||
              uppercaseCustomList.contains(criteria.name) ||
              uppercaseCustomList.contains(criteria.dialCode))
          .toList();
    }

    return CountryInfoPickerState(elements);
  }
}

class CountryInfoPickerState extends State<CountryInfoPicker> {
  CountryInfoModel? selectedItem;
  List<CountryInfoModel> elements = [];
  List<CountryInfoModel> favoriteElements = [];

  CountryInfoPickerState(this.elements);

  @override
  Widget build(BuildContext context) {
    Widget internalWidget;
    if (widget.builder != null) {
      internalWidget = InkWell(
        onTap: _showCountryCodePicker,
        child: widget.builder!(selectedItem),
      );
    } else {
      internalWidget = InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        onTap: _showCountryCodePicker,
        child: TextFormField(
          enabled: false,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            suffixIcon: widget.suffixIcon,
            labelText: _getTypeTitle(widget.countryPickerType,context),
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
            floatingLabelAlignment:widget.floatingLabelAlignment,
            hintText: selectedItem!=null?_getTextValue(selectedItem!,widget.countryPickerType):_getTypeTitle(widget.countryPickerType,context),
            hintFadeDuration: const Duration(milliseconds: 100),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: const TextStyle(color: Colors.black),
            contentPadding: const EdgeInsetsDirectional.only(start: 22 ,top: 20, bottom: 16),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          ),
        ),
      );
    }
    return internalWidget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    elements = elements.map((element) => element.localize(context)).toList();
    _onInit(selectedItem);
  }

  @override
  void didUpdateWidget(CountryInfoPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialSelection != widget.initialSelection) {
      if (widget.initialSelection != null) {
        selectedItem = elements.firstWhere(
            (criteria) =>
                (criteria.code!.toUpperCase() ==
                    widget.initialSelection!.toUpperCase()) ||
                (criteria.dialCode == widget.initialSelection) ||
                (criteria.name!.toUpperCase() ==
                    widget.initialSelection!.toUpperCase()),
            orElse: () => elements[0]);
      }
      _onInit(selectedItem);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
          (item) =>
              (item.code!.toUpperCase() ==
                  widget.initialSelection!.toUpperCase()) ||
              (item.dialCode == widget.initialSelection) ||
              (item.name!.toUpperCase() ==
                  widget.initialSelection!.toUpperCase()),
          orElse: () => elements[0]);
    }
    favoriteElements = elements
        .where((item) =>
            widget.favorite.firstWhereOrNull((criteria) =>
                item.code!.toUpperCase() == criteria.toUpperCase() ||
                item.dialCode == criteria ||
                item.name!.toUpperCase() == criteria.toUpperCase()) !=
            null)
        .toList();
  }


  void _showCountryCodePicker() {
    if (widget.showPage) {
      _showCountryCodePickerPage();
    } else {
      _showCountryCodePickerDialog();
    }
  }

  void _showCountryCodePickerDialog() async {
    final item = await showDialog(
      barrierColor: widget.barrierColor ?? Colors.grey.withOpacity(0.5),
      context: context,
      builder: (context) => Center(
        child: Dialog(
          child: _SelectionDialog(
            elements,
            favoriteElements,
            emptySearchBuilder: widget.emptySearchBuilder,
            searchDecoration: widget.searchDecoration,
            searchStyle: widget.searchStyle,
            textStyle: widget.dialogTextStyle,
            boxDecoration: widget.boxDecoration,
            showFlag: widget.showFlagDialog ?? widget.showFlag,
            flagWidth: widget.flagWidth,
            size: widget.dialogSize,
            backgroundColor: widget.dialogBackgroundColor,
            barrierColor: widget.barrierColor,
            hideSearch: widget.hideSearch,
            closeIcon: widget.closeIcon,
            flagDecoration: widget.flagDecoration,
          ),
        ),
      ),
    );

    if (item != null) {
      setState(() {
        selectedItem = item;
      });

      _publishSelection(item);
    }
  }

  void _showCountryCodePickerPage() async {
    final item = await Get.to(
      ()=>
      _SelectionPage(
        elements,
        favoriteElements,
        emptySearchBuilder: widget.emptySearchBuilder,
        searchDecoration: widget.searchDecoration,
        searchStyle: widget.searchStyle,
        textStyle: widget.dialogTextStyle,
        boxDecoration: widget.boxDecoration,
        showFlag: widget.showFlagDialog ?? widget.showFlag,
        flagWidth: widget.flagWidth,
        size: widget.dialogSize,
        backgroundColor: widget.dialogBackgroundColor,
        barrierColor: widget.barrierColor,
        hideSearch: widget.hideSearch,
        closeIcon: widget.closeIcon,
        flagDecoration: widget.flagDecoration,
        type: widget.countryPickerType,
      ),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    );

    if (item != null) {
      setState(() {
        selectedItem = item;
      });

      _publishSelection(item);
    }
  }

  void _publishSelection(CountryInfoModel countryCode) {
    if (widget.onChanged != null) {
      widget.onChanged!(countryCode);
    }
  }

  void _onInit(CountryInfoModel? countryCode) {
    if (widget.onInit != null) {
      widget.onInit!(countryCode);
    }
  }
}
