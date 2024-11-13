  METHOD if_http_extension~handle_request.

    DATA(v_type_crud) = server->request->get_header_field( name = `~request_method` ).

    CASE v_type_crud.
      WHEN 'POST'.

        " Selecionar Dados
        SELECT *
          FROM ydlt_000
          INTO TABLE @DATA(lt_partner).

        " Converter Obejeto SAP em JSON
        DATA(ls_json_response) = /uI2/cl_json=>serialize( EXPORTING data = lt_partner ).

        " Retornar na API
        server->response->set_cdata( data = ls_json_response ).

      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

  " Exemplo de JSON
* Estrutura
*           {
*             "name": "Gabriel Cordeiro"
*           }
* Tabela
*           [
*             { "name": "Gabriel Cordeiro", "sexo":"M" },
*             { "name": "Lucas Cordeiro", "sexo":"M"  }
*           ]