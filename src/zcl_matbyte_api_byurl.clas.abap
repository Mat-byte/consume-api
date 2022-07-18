CLASS zcl_matbyte_api_byurl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_matbyte_api_byurl IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "https://api.sap.com/api/campaign/tryout

    DATA client TYPE REF TO if_web_http_client.

    TRY.

        DATA(dest) = cl_http_destination_provider=>create_by_url( 'https://sandbox.api.sap.com/sap/c4c/odata/v1/c4codataapi/CampaignCollection?$inlinecount=allpages&$top=5' ).

        client = cl_web_http_client_manager=>create_by_http_destination( dest ).

        client->get_http_request( )->set_header_field( i_name = 'APIKey' i_value = 'Y96sjQAEmcY8TG4hUcAwexyf0L7Vpt57' ).
        client->get_http_request( )->set_header_field( i_name = 'DataServiceVersion' i_value = '2.0' ).
        client->get_http_request( )->set_header_field( i_name = 'Accept' i_value = 'application/json' ).

        DATA(response) = client->execute( if_web_http_client=>get )->get_text(  ).

        client->close( ).

      CATCH: cx_http_dest_provider_error, cx_web_http_client_error INTO DATA(exception).

        out->write( exception->get_text( ) ).

    ENDTRY.

    out->write( response ).

    "Code Snippet from https://api.sap.com/api/campaign/tryout
*    DATA: lo_http_client TYPE REF TO if_http_client.
*    DATA: response TYPE string.
*
*    "create HTTP client by url
*    "API endpoint for API sandbox
*    CALL METHOD cl_http_client=>create_by_url
*      EXPORTING
*        url                = 'https://sandbox.api.sap.com/sap/c4c/odata/v1/c4codataapi/CampaignCollection?$inlinecount=allpages&$top=20'
*      IMPORTING
*        client             = lo_http_client
*      EXCEPTIONS
*        argument_not_found = 1
*        plugin_not_active  = 2
*        internal_error     = 3
*        OTHERS             = 4.
*
*    IF sy-subrc <> 0.
*      "error handling
*    ENDIF.
*
*    "setting request method
*    lo_http_client->request->set_method('GET').
*
*    "adding headers
*    "API Key for API Sandbox
*    lo_http_client->request->set_header_field( name = 'APIKey' value = 'Y96sjQAEmcY8TG4hUcAwexyf0L7Vpt57' ).
*    lo_http_client->request->set_header_field( name = 'DataServiceVersion' value = '2.0' ).
*    lo_http_client->request->set_header_field( name = 'Accept' value = 'application/json' ).
*
*
*    CALL METHOD lo_http_client->send
*      EXCEPTIONS
*        http_communication_failure = 1
*        http_invalid_state         = 2
*        http_processing_failed     = 3
*        http_invalid_timeout       = 4
*        OTHERS                     = 5.
*
*    IF sy-subrc = 0.
*      CALL METHOD lo_http_client->receive
*        EXCEPTIONS
*          http_communication_failure = 1
*          http_invalid_state         = 2
*          http_processing_failed     = 3
*          OTHERS                     = 5.
*    ENDIF.
*
*    IF sy-subrc <> 0.
*      "error handling
*    ENDIF.
*
*    response = lo_http_client->response->get_cdata( ).
*
*    WRITE: 'response: ', response.

  ENDMETHOD.

ENDCLASS.
