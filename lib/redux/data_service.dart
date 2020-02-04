import 'package:sitediary/data_cache/paging_data.dart';
import 'package:sitediary/datas/http_handler.dart';
import 'package:sitediary/redux/state_app.dart';
import 'package:http/http.dart' as http;
import 'package:sitediary/datas/eform/eform.dart';
import 'package:sitediary/datas/eform/eform_record.dart';

import 'package:sitediary/datas/request_sub_item.dart';
import 'package:sitediary/redux/eform_action.dart';
import 'package:redux/redux.dart';

//467
class BackendService {

  static Future<List<EForm>> getEFormEmpty() async {
    return List<EForm>();
  }

  static Future<List<EForm>> getEForms(AppState state, int offset, int offsetCount, bool isActiveScreen) async {

    if (!isActiveScreen) return getEFormEmpty();
    print('getEForms by http: $offset * $offsetCount ');
    ResponseItem ri ;

      RequestHandler rh = RequestHandler.fromListItemRequest(state.user, 2, offset, offsetCount);
      final responseBody = (await http.post(state .serverUrlBase, body: rh.toJsonString())).body;
        // The response body is an array of items
        ri = ResponseItem.fromJsonString(responseBody);

        if (ri.ex!=null){
          print(ri.ex);
          throw(ri.ex);
        }

        if (ri.eformList==null) ri.eformList =List<EForm>();

         //if (ri.ex!=null) throw ri.ex;
      return ri.eformList;
      //return ri.dataList;
  }

  static Future<List<EFormRecord>> getEFormRecordEmpty() async {
    return List<EFormRecord>();
  }

  static Future<List<EFormRecord>> getEFormRecordsUseless(
      Store<AppState>  store, String eFormKey,
      int section, int pageIndex, int pageSize,
      bool isActiveScreen) async {

    if (!isActiveScreen) return getEFormRecordEmpty();
    final c = await getEFormRecordContainer(store, eFormKey, section, pageIndex, pageSize, isActiveScreen);
    return c.items;

  }

  static Future<PagingItemCollection<EFormRecord>> getEFormRecordContainerEmpty() async{
    return  PagingItemCollection<EFormRecord>(
      items: List<EFormRecord>(),
      totalProducts: 0,
      pageNumber: 0,
      pageSize:0 ,
    );
  }

  static Future<PagingItemCollection<EFormRecord>> getEFormRecordContainer(
      Store<AppState>  store, String eFormKey,
      int section, int pageIndex,
      int pageSize, bool isActiveScreen
      ) async {

    int offset = pageSize * pageIndex;
    int offsetCount = pageSize;

    print('getEFormRecords by http: $offset * $offsetCount, section: $section');

    //store.state.user.userSelectedSection = section ;
    ResponseItem ri ;
    RequestSubItem subItem = RequestSubItem.fromUser(store.state.user);
    subItem.skip = offset;
    subItem.topN = offsetCount;
    subItem.eFormKey = eFormKey;
    subItem.userSelectedSection = section;
    RequestHandler rh = RequestHandler.fromSubItem(subItem, 3);

    final responseBody = (await http.post(store.state.serverUrlBase, body: rh.toJsonString())).body;
    // The response body is an array of items
    ri = ResponseItem.fromJsonString(responseBody);

    if (ri.ex!=null){
      print(ri.ex);
      throw(ri.ex);
    }
    if (eFormKey!=ri.eformObject.eFormKey) store.dispatch(ChangeCurrentEFormAction(ri.eformObject));

    List<EFormRecord> list = List<EFormRecord>();
    if (ri.eformObject!=null) list = ri.eformObject.recordList;

    //int totalItemCount = 100;

    PagingItemCollection<EFormRecord> c = PagingItemCollection<EFormRecord>(
      items: list,
      totalProducts: ri.totalItem,
      pageNumber: pageIndex,
      pageSize:pageSize ,
    );

    // if (ri.eformList==null) ri.eformList =List<EForm>();
    //if (ri.ex!=null) throw ri.ex;
    return c;
    //return ri.dataList;
  }

}