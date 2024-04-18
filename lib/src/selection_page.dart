part of '../country_info_picker.dart';


class _SelectionPage extends StatefulWidget {
  final List<CountryInfoModel> elements;
  final InputDecoration searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? textStyle;
  final BoxDecoration? boxDecoration;
  final WidgetBuilder? emptySearchBuilder;
  final bool? showFlag;
  final double flagWidth;
  final Decoration? flagDecoration;
  final Size? size;
  final bool hideSearch;
  final Icon? closeIcon;

  /// Background color of SelectionPage
  final Color? backgroundColor;

  /// Boxshaow color of SelectionPage that matches CountryCodePicker barrier color
  final Color? barrierColor;

  /// elements passed as favorite
  final List<CountryInfoModel> favoriteElements;

  final CountryPickerType type;

  _SelectionPage(this.elements,
      this.favoriteElements, {
        Key? key,
        this.emptySearchBuilder,
        InputDecoration searchDecoration = const InputDecoration(),
        this.searchStyle,
        this.textStyle,
        this.boxDecoration,
        this.showFlag,
        this.flagDecoration,
        this.flagWidth = 32,
        this.size,
        this.backgroundColor,
        this.barrierColor,
        this.hideSearch = false,
        this.closeIcon,
        this.type = CountryPickerType.DialCodeAndCountryCode,
      })
      : searchDecoration = searchDecoration.prefixIcon == null
      ? searchDecoration.copyWith(prefixIcon: const Icon(Icons.search))
      : searchDecoration,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<_SelectionPage> {
  /// this is useful for filtering purpose
  late List<CountryInfoModel> filteredElements;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: Theme
            .of(context)
            .appBarTheme
            .titleTextStyle!
            .copyWith(color: Colors.black, fontSize: 18),
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: widget.closeIcon ?? const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(_getAppBarTitle(widget.type,context)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 10),
          child: Column(
            children: [
              if (!widget.hideSearch) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    autofocus: false,
                    onChanged: _filterElements,
                    // textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      hintText: "Search",
                      fillColor: Colors.blueGrey.shade50,
                      filled: true,
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w300,
                      ),
                      prefixIconColor: const Color(0XFF8592AD),
                      suffixIconColor: const Color(0XFF8592AD),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0XFF8592AD),
                        size: 29,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ]
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 60),
        children: [
          widget.favoriteElements.isEmpty
              ? const DecoratedBox(decoration: BoxDecoration())
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget.favoriteElements.map(
                    (f) =>
                    SimpleDialogOption(
                      child: _buildOption(f),
                      onPressed: () {
                        _selectItem(f);
                      },
                    ),
              ),
              const Divider(),
            ],
          ),
          if (filteredElements.isEmpty)
            _buildEmptySearchWidget(context)
          else
            ...filteredElements.map(
                  (e) =>
                  SimpleDialogOption(
                    child: _buildOption(e),
                    onPressed: () {
                      _selectItem(e);
                    },
                  ),
            ),
        ],
      ),
    );
  }




    Widget _buildOption(CountryInfoModel e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: SizedBox(
          width: 400,
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              if (widget.showFlag!)
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(right: 16.0),
                    decoration: widget.flagDecoration,
                    clipBehavior:
                    widget.flagDecoration == null ? Clip.none : Clip.hardEdge,
                    child: Image.asset(
                      e.flagUri!,
                      // package: 'country_code_picker',
                      width: widget.flagWidth,
                    ),
                  ),
                ),
              Expanded(
                flex: 4,
                child: Text(
                  _getText(e, widget.type),
                  overflow: TextOverflow.fade,
                  style: widget.textStyle,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildEmptySearchWidget(BuildContext context) {
      if (widget.emptySearchBuilder != null) {
        return widget.emptySearchBuilder!(context);
      }

      return Center(
        child: Text(CountryLocalizations.of(context)?.translate('no_country') ??
            'No country found'),
      );
    }

    @override
    void initState() {
      filteredElements = widget.elements;
      super.initState();
    }

    void _filterElements(String s) {
      s = s.toUpperCase();
      setState(() {
        filteredElements = widget.elements
            .where((e) =>
        e.code!.contains(s) ||
            e.dialCode!.contains(s) ||
            e.name!.toUpperCase().contains(s))
            .toList();
      });
    }

    void _selectItem(CountryInfoModel e) {
      Navigator.pop(context, e);
    }
  }
