// Generated code for this AppBar Widget...
AppBar(
  backgroundColor: Color(0xFF7AA062),
  automaticallyImplyLeading: false,
  leading: FlutterFlowIconButton(
    borderColor: Colors.transparent,
    borderRadius: 30,
    borderWidth: 1,
    buttonSize: 60,
    icon: Icon(
      Icons.arrow_back_rounded,
      color: FlutterFlowTheme.of(context).primaryText,
      size: 30,
    ),
    onPressed: () async {
      context.safePop();
    },
  ),
  title: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(60, 0, 0, 0),
    child: Text(
      FFLocalizations.of(context).getText(
        '1emjpuqf' /* EcoBladi */,
      ),
      style: FlutterFlowTheme.of(context).headlineMedium.override(
            fontFamily: 'Outfit',
            color: FlutterFlowTheme.of(context).primaryText,
            fontSize: 35,
            letterSpacing: 0,
          ),
    ),
  ),
  actions: [
    Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
      child: FlutterFlowIconButton(
        borderColor: Color(0xFF7AA062),
        borderRadius: 20,
        borderWidth: 1,
        buttonSize: 40,
        fillColor: Color(0xFF7AA062),
        icon: Icon(
          Icons.menu,
          color: FlutterFlowTheme.of(context).primaryText,
          size: 30,
        ),
        onPressed: () {
          print('IconButton pressed ...');
        },
      ),
    ),
  ],
  centerTitle: false,
  elevation: 2,
)
