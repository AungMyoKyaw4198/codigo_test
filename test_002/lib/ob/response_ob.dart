class ResponseOb {
  MsgState? msgState;
  dynamic data;
  ErrState? errState;
  PageState? pageState;

  ResponseOb({this.msgState, this.data, this.errState});
}

enum MsgState { loading, data, error }

enum ErrState { serverErr, noAuthErr, notFoundErr, noConnectionErr, unKnownErr }

enum PageState { first, load, end }
