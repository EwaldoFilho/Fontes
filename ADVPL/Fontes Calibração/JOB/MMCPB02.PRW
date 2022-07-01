#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"    

/*/{Protheus.doc} MMCPB02 - Fonte responsável por atualizar o Status da calibragem.
@return		Retorno
@author		André Longhini
@version	1.0
@since		24/03/2022
@obs	
*/

User Function MMCPB02()

     Local aArea              := GetArea()
     Local _cQry              := ""
     Local cStatus            := ""
     Local dDataBase          := Date()
     Local dDataProx          := 0     
     Local cFil               := "0101"
     Local cCodCC             := ""
     Local cProd              := ""
     Local cSerie             := ""
     Local nDias              := 0
     Local nDiasAlt           := 0
     Local cEmp               := "01"
     Local cTpProd            := ""
     Local cBem               := ""
     Local cTpAtivo           := ""

    PREPARE ENVIRONMENT EMPRESA ( cEmp ) FILIAL ( cFil )      


     //Query que busca os dados dos equipamentos
     _cQry := " SELECT ZZD_FILIAL, ZZD_CODCC, ZZD_TPPROD,ZZD_ATIVO, ZZD_CODPR, ZZD_CODATI, ZZD_NSERIE,ZZD_DTCAL2,ZZD_STATUS"
     _cQry += " FROM "+RetSqlName("ZZD")
     _cQry += " WHERE ZZD_STATUS <> '3'" // Diferente de vencido
     _cQry += " AND D_E_L_E_T_<>'*'"
     _cQry += " AND ZZD_MSBLQL <>'1'"
     TcQuery _cQry New Alias "TZZD"     



          //Atualizando status
          While !(TZZD->(EoF()))

               nDiasAlt  := GETMV("COM_CCP01")	
               cFiL      := TZZD->ZZD_FILIAL
               cCodCC    := TZZD->ZZD_CODCC
               cTpProd   := TZZD->ZZD_TPPROD
               cTpAtivo  := TZZD->ZZD_ATIVO
               cProd     := TZZD->ZZD_CODPR
               cBem      := TZZD->ZZD_CODATI
               cSerie    := TZZD->ZZD_NSERIE
               dDataProx := STOD(TZZD->ZZD_DTCAL2)
               cStatus   := TZZD->ZZD_STATUS
               nDias     := (DateDiffDay(dDataBase,dDataProx))


               If cTpProd == 'N' 
               
                    If cStatus $ '2|3' .and. nDias > nDiasAlt
                         DbSelectArea('ZZD')
                         ZZD->(DbSetOrder(1))
                         If ZZD->(DbSeek(cFiL + cCodCC + cProd + cSerie))
                              RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.
                                   
                                   ZZD->ZZD_STATUS := "1" // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              
                              ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                         endIF
                    EndIF

                    If cStatus == '1' .and. nDias <= nDiasAlt .and. dDataBase < dDataProx
                         DbSelectArea('ZZD')
                         ZZD->(DbSetOrder(1))
                         If ZZD->(DbSeek(cFiL + cCodCC + cProd + cSerie))
                              RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.
                                   
                                   ZZD->ZZD_STATUS := "2" // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              
                              ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                         endIF
                    EndIF

                    If cStatus == '2' .and. dDataBase >= dDataProx
                         DbSelectArea('ZZD')
                         ZZD->(DbSetOrder(1))
                         If ZZD->(DbSeek(cFiL + cCodCC + cProd + cSerie))
                              RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.
                                   
                                   ZZD->ZZD_STATUS := "3" // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              
                              ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                         endIF
                    EndIF

               ELSEIF cTpProd == 'S' .and. cTpAtivo == 'S'

                    If cStatus $ '2|3' .and. nDias > nDiasAlt
                         DbSelectArea('ZZD')
                         ZZD->(DbSetOrder(2))
                         If ZZD->(DbSeek(cFiL + cCodCC + cBem + cSerie))
                              RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.
                                   
                                   ZZD->ZZD_STATUS := "1" // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              
                              ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                         endIF
                    EndIF
                    If cStatus == '1' .and. nDias <= nDiasAlt .and. dDataBase < dDataProx
                         DbSelectArea('ZZD')
                         ZZD->(DbSetOrder(2))
                         If ZZD->(DbSeek(cFiL + cCodCC + cBem + cSerie))
                              RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.
                                   
                                   ZZD->ZZD_STATUS := "2" // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              
                              ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                         endIF
                    EndIF

                    If cStatus == '2' .and. dDataBase >= dDataProx
                         DbSelectArea('ZZD')
                         ZZD->(DbSetOrder(2))
                         If ZZD->(DbSeek(cFiL + cCodCC + cBem + cSerie))
                              RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.
                                   
                                   ZZD->ZZD_STATUS := "3" // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              
                              ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                         endIF
                    EndIF

               ELSEIF cTpProd == 'S' .and. cTpAtivo == 'N'

                    If cStatus $ '2|3' .and. nDias > nDiasAlt
                         DbSelectArea('ZZD')
                         ZZD->(DbSetOrder(1))
                         If ZZD->(DbSeek(cFiL + cCodCC + cProd + cSerie))
                              RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.
                                   
                                   ZZD->ZZD_STATUS := "1" // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              
                              ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                         endIF
                    EndIF

                    If cStatus == '1' .and. nDias <= nDiasAlt .and. dDataBase < dDataProx
                         DbSelectArea('ZZD')
                         ZZD->(DbSetOrder(1))
                         If ZZD->(DbSeek(cFiL + cCodCC + cProd + cSerie))
                              RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.
                                   
                                   ZZD->ZZD_STATUS := "2" // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              
                              ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                         endIF
                    EndIF

                    If cStatus == '2' .and. dDataBase >= dDataProx
                         DbSelectArea('ZZD')
                         ZZD->(DbSetOrder(1))
                         If ZZD->(DbSeek(cFiL + cCodCC + cProd + cSerie))
                              RecLock("ZZD", .F.) //Trava o registro para alteração , caso queira INCLUIR troque o .F. por .T.
                                   
                                   ZZD->ZZD_STATUS := "3" // AQUI VAI O VALOR QUE VOCE QUER GRAVAR NO CAMPO
                              
                              ZZD->(MsUnLock()) // AQUI VOCE DESTRAVA O REGISTRO CRIADO OU ALTERADO
                         endIF
                    EndIF

               EndIF
               
               TZZD->(DbSkip())
          EndDo

    //Fecha Query
    TZZD->(DbCloseArea())
    RestArea(aArea)

    Reset ENVIRONMENT
Return
