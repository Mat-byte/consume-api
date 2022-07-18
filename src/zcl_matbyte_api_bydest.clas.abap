CLASS zcl_matbyte_api_bydest DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_matbyte_api_bydest IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TRY.

        DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination(
          i_name                  = 'STREETMAP'
          i_authn_mode = if_a4c_cp_service=>service_specific ).

        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).
        DATA(lo_request) = lo_http_client->get_http_request( ).

        DATA(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>get ).

        out->write( lo_response->get_text( ) ).

      CATCH cx_root INTO DATA(lx_exception).

        out->write( lx_exception->get_text( ) ).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.
