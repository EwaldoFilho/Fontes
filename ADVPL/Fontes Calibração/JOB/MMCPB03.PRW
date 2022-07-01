#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"    

/*/{Protheus.doc} MMCPB03 - Fonte responsável por atualizar o Centro de Custo do Equipamento. 
@return		Retorno
@author		André Longhini
@version	1.0
@since		06/05/2022
@obs	
*/

User Function MMCPB03()

     Local aArea              := GetArea()
     Local _cQry              := ""
     Local cFil               := "0101"
     Local cCodCC             := ""
     Local cSerie             := ""
     Local cEmp               := "01"
     Local cBem               := ""
     Local cBaixa             := ""

    PREPARE ENVIRONMENT EMPRESA ( cEmp ) FILIAL ( cFil )      


     //Query que busca os dados dos equipamentos
     _cQry := " SELECT ZZD.ZZD_FILIAL,ZZD_CODCC, ZZD_TPPROD, ZZD_CODATI, N1.N1_CBASE, N3.N3_CUSTBEM, N3.N3_BAIXA, CTT.CTT_DESC01, ZZD.ZZD_NSERIE, ZZD.ZZD_MSBLQL"
     _cQry += " FROM "+RetSqlName("ZZD") + " ZZD"
     _cQry += " INNER JOIN "+RetSQLName("SN1")+" N1 " 	
     _cQry += " ON N1.N1_FILIAL = (Trim(ZZD.ZZD_FILIAL) + '01') " 
     _cQry += " AND N1.N1_CBASE = ZZD.ZZD_CODATI " 
     _cQry += " AND N1.D_E_L_E_T_ = '' " 
     _cQry += " INNER JOIN "+RetSQLName("SN3")+" N3 "
     _cQry += " ON N3.N3_FILIAL = N1.N1_FILIAL " 
     _cQry += " AND N3.N3_CBASE = N1.N1_CBASE " 
     _cQry += " AND N3.D_E_L_E_T_ = '' " 
     _cQry += " INNER JOIN "+RetSQLName("CTT")+" CTT "
     _cQry += " ON CTT.CTT_FILIAL = SUBSTRING(N3.N3_FILIAL,1,2) " 
     _cQry += " AND CTT.CTT_CUSTO = N3.N3_CUSTBEM " 
     _cQry += " AND CTT.D_E_L_E_T_ = '' " 
     _cQry += " WHERE ZZD.D_E_L_E_T_<>'*'" // Diferente de vencido
     _cQry += " AND ZZD.ZZD_TPPROD = 'S'"
     _cQry += " AND ZZD.ZZD_ATIVO = 'S'"
     _cQry += " AND ZZD.ZZD_MSBLQL <> '1'"
     TcQuery _cQry New Alias "TZZD"     



          //Atualizando status
          While !(TZZD->(EoF()))

               cCodCC         := TZZD->ZZD_CODCC
               cCodAtt        := TZZD->N3_CUSTBEM
               cFiL           := TZZD->ZZD_FILIAL
               cBem           := TZZD->ZZD_CODATI
               cSerie         := TZZD->ZZD_NSERIE
               cDescCusto     := TZZD->CTT_DESC01
               cBaixa         := TZZD->N3_BAIXA

               If cCodCC != cCodAtt .and. cCodAtt != ""
                    DbSelectArea('ZZD')
                    ZZD->(DbSetOrder(2))
                    If ZZD->(DbSeek(cFiL +  cCodCC + cBem + cSerie))
                         RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.
                                   
                              ZZD->ZZD_CODCC      := cCodAtt // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              ZZD->ZZD_DESCCC     := cDescCusto // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              
                         ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                    endIF
               EndIF

               If cBaixa $ "1|2" 
                    DbSelectArea('ZZD')
                    ZZD->(DbSetOrder(2))
                    If ZZD->(DbSeek(cFiL +  cCodCC + cBem + cSerie))
                         RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.

                         ZZD->ZZD_STATUS := "4"          
                         ZZD->ZZD_MSBLQL := "1"
                         

                         ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                    endIF
               EndIF
               
               TZZD->(DbSkip())
          EndDo

    //Fecha Query
    TZZD->(DbCloseArea())
    RestArea(aArea)

    Reset ENVIRONMENT
Return
