#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"   

/**************************************************************************************************
{Protheus.doc} MMJOBEMAIL
@description	Rotina para gerar um aviso por email quanto ao vencimento dos equipamentos.
@type   		Funcao	
@author			André Luis Maximiano Longhini
@version   		1.00
@since     		29/03/2022
@database		29/03/2022
@country		Brasil
@language		PT-BR		
@TesteUser     testeMailSched()
@return			Nil 			
*****************************************************************************************************/
User Function MMJOBEMAIL()

    Local aArea                 := GetArea()
    Local _cQry                 := ""
    Local _cCodCC               := ""
    Local cTpProd               := ""
    Local _cDesCC               := ""
    Local _cCodProd             := ""
    Local _cDesProd             := ""
    Local _cSerie               := ""
    Local _dDataProx            := 0
    Local _cAviso               := ""
    Local _DataProx             := ""
    Local dDataBase             := Date()
    Local nDias                 := 0
    Local nDiaNot               := 0
    Local nDiaNot2              := 0
    Local nDiaNot3              := 0
    Local nDiaNot4              := 0
    Local cStatus               := ""
    Local cEmp                  := "01"
    Local   cFil                := "0101"
    Local cTpAtivo              := ""

    PREPARE ENVIRONMENT EMPRESA ( cEmp ) FILIAL ( cFil )

    //Query que busca os dados dos equipamentos próximo do vencimento
     _cQry := " SELECT ZZD_FILIAL,ZZD_TPPROD, ZZD_ATIVO, ZZD_CODCC, ZZD_DESCCC, ZZD_CODPR, ZZD_DESCPD, ZZD_CODATI, ZZD_DESCAT, ZZD_NSERIE,ZZD_DTCAL2,ZZD_STATUS"
     _cQry += " FROM "+RetSqlName("ZZD")
     _cQry += " WHERE ZZD_STATUS <> '1'" // Diferente de valido
     _cQry += " AND D_E_L_E_T_ <>'*'"
     _cQry += " AND ZZD_MSBLQL <>'1'"
    TcQuery _cQry New Alias "TZZD"
    DbSelectArea("TZZD")
    TZZD->(DbGoTop())


        Conout("Verificando se existe calibragens próximas do vencimento ou vencidas")
        //----------------------------------------------------------------------------
        // Funcao para gerar as variáveis a encaminhar via e-mail
        //----------------------------------------------------------------------------
        While !(TZZD->(EoF()))
           
            _cCodCC         := TZZD->ZZD_CODCC
            _cDesCC         := TZZD->ZZD_DESCCC
            cTpProd         := TZZD->ZZD_TPPROD
            _cTpAtivo        := TZZD->ZZD_ATIVO

            if cTpProd == 'N'

                _cCodProd    := TZZD->ZZD_CODPR
                _cDesProd    := TZZD->ZZD_DESCPD

            ELSEIF cTpProd == 'S' .and. cTpAtivo == 'S'

                _cCodProd    := TZZD->ZZD_CODATI
                _cDesProd    := TZZD->ZZD_DESCAT

            ELSEIF cTpProd == 'S' .and. cTpAtivo == 'N'

                _cCodProd    := TZZD->ZZD_CODPR
                _cDesProd    := TZZD->ZZD_DESCPD

            ENDIF                

            _cSerie         := TZZD->ZZD_NSERIE
            cStatus         := TZZD->ZZD_STATUS
            _dDataProx      := STOD(TZZD->ZZD_DTCAL2)
            nDias           := (DateDiffDay(dDataBase,_dDataProx))
            nDiaNot         := GETMV("COM_CCP02")
            nDiaNot2        := GETMV("COM_CCP03")
            nDiaNot3        := GETMV("COM_CCP04")
            nDiaNot4        := GETMV("COM_CCP05")

            iF cStatus == '2'

                If nDias == nDiaNot
                    _cAviso     := ("Informamos que o Equipamento de código " +alltrim(_cCodProd)+ " - " +alltrim(_cDesProd)+ " e número de série " +alltrim(_cSerie)+ ", pertencente ao contrato " +alltrim(_cCodCC)+ " - " +alltrim(_cDesCC)+ ", encontra-se próximo ao vencimento da calibração.")
                    _DataProx   := ("A data prevista da próxima calibração é: " +DTOC(_dDataProx)+ ".")
                    
                    
                    //----------------------------------------------------------------------------
                    // Funcao para gerar o HTML de envio
                    //----------------------------------------------------------------------------
                    MMPHTML(_cAviso, _DataProx)
                endif

                If nDias == nDiaNot2
                    _cAviso     := ("Informamos que o Equipamento de código " +alltrim(_cCodProd)+ " - " +alltrim(_cDesProd)+ " e número de série " +alltrim(_cSerie)+ ", pertencente ao contrato " +alltrim(_cCodCC)+ " - " +alltrim(_cDesCC)+ ", encontra-se próximo ao vencimento da calibração.")
                    _DataProx   := ("A data prevista da próxima calibração é: " +DTOC(_dDataProx)+ ".")
                    

                    
                    //----------------------------------------------------------------------------
                    // Funcao para gerar o HTML de envio
                    //----------------------------------------------------------------------------
                    MMPHTML(_cAviso, _DataProx)
                endif

            elseif cStatus == '3'

                If nDias == nDiaNot3
                    _cAviso     := ("Informamos que o Equipamento de código " +alltrim(_cCodProd)+ " - " +alltrim(_cDesProd)+ " e número de série " +alltrim(_cSerie)+ ", pertencente ao contrato " +alltrim(_cCodCC)+ " - " +alltrim(_cDesCC)+ ", encontra-se com a calibração vencida.")
                    _DataProx   := ("A data prevista da próxima calibração era: " +DTOC(_dDataProx)+ ". O mesmo encontra-se vencido a " +cValToChar(nDias)+ " dias.")
                    

                    
                    //----------------------------------------------------------------------------
                    // Funcao para gerar o HTML de envio
                    //----------------------------------------------------------------------------
                    MMPHTML(_cAviso, _DataProx)
                endif
                
                If nDias >= nDiaNot4
                    _cAviso     := ("Informamos que o Equipamento de código " +alltrim(_cCodProd)+ " - " +alltrim(_cDesProd)+ " e número de série " +alltrim(_cSerie)+ ", pertencente ao contrato " +alltrim(_cCodCC)+ " - " +alltrim(_cDesCC)+ ", encontra-se com a calibração vencida.")
                    _DataProx   := ("A data prevista da calibração era: " +DTOC(_dDataProx)+ ". O mesmo encontra-se vencido a " +cValToChar(nDias)+ " dias.")
                    

                    
                    //----------------------------------------------------------------------------
                    // Funcao para gerar o HTML de envio
                    //----------------------------------------------------------------------------
                    MMPHTML(_cAviso, _DataProx)
                endif

            ENDIF

            TZZD->(DbSkip())
        EndDo

        Conout("Finalizada rotina de notificação de calibrações próximas ao vencimento ou vencidas")
    
    //Fecha Query
    TZZD->(DbCloseArea())
    RestArea(aArea)


Return 

/**************************************************************************************************
{Protheus.doc} MMJOBEMAIL
@description	Monta o html a enviar por email 
@type   		Funcao	
@author			André Luis Maximiano Longhini
@version   		1.00
@since     		29/03/2022
@database		29/03/2022
@country		Brasil
@language		PT-BR
@param			
@return			Nil 			
*****************************************************************************************************/
Static Function MMPHTML( _cAviso, _DataProx)
Local _cMail    := alltrim(GETMV("COM_CCP06"))
Local _cMsgMail := ""
Local cTitulo   := "Calibração de Equipamentos"

_cMsgMail := '    <!DOCTYPE html>
_cMsgMail := '    <html lang="en" xmlns="http://www.w3.org/1999/xhtml" xmlns:o="urn:schemas-microsoft-com:office:office"> 
_cMsgMail += '        <head> 
_cMsgMail += '            <meta charset="UTF-8">
_cMsgMail += '            <meta name="viewport" content="width=device-width,initial-scale=1">
_cMsgMail += '            <meta name="x-apple-disable-message-reformatting">
_cMsgMail += '            <!--[if mso]>
_cMsgMail += '            <noscript>
_cMsgMail += '               <xml>
_cMsgMail += '                 <o:OfficeDocumentSettings>
_cMsgMail += '                   <o:PixelsPerInch>96</o:PixelsPerInch>
_cMsgMail += '                 </o:OfficeDocumentSettings>
_cMsgMail += '               </xml>
_cMsgMail += '            </noscript>
_cMsgMail += '            <![endif]-->
_cMsgMail += '            <style type="text/css">
_cMsgMail += '                 table, td, div, h1, p {font-family: Arial, sans-serif;}
_cMsgMail += '            </style>
_cMsgMail += '        </head>
_cMsgMail += '        <body style="margin:0;padding:0;">
_cMsgMail += '                <table role="presentation" style="width:100%;border-collapse:collapse;border:0;border-spacing:0;background:#ffffff;">
_cMsgMail += '                    <tr>
_cMsgMail += '                        <td align="center" style="padding:0;">
_cMsgMail += '                           <table role="presentation" style="width:602px;border-collapse:collapse;border:1px solid #cccccc;border-spacing:0;text-align:left;">
_cMsgMail += '                               <tr>
_cMsgMail += '                                  <td align="center" style="padding:40px 0 30px 0;background:#B81330;">
_cMsgMail += '                                    <img src="https://i.ibb.co/C8Wsh1g/LOGO-MED-NEGATIVO.png"
_cMsgMail += '                                     alt="logo"
_cMsgMail += '                                     width="300"
_cMsgMail += '                                     style="height:auto;display:block;" />
_cMsgMail += '                                  </td>
_cMsgMail += '                               </tr>
_cMsgMail += '                               <tr>
_cMsgMail += '                                  <td style="padding:36px 30px 42px 30px;">
_cMsgMail += '                                    <table role="presentation" style="width:100%;border-collapse:collapse;border:0;border-spacing:0;">
_cMsgMail += '                                       <tr>
_cMsgMail += '                                          <td style="padding:0 0 36px 0;color:#153643;">
_cMsgMail += '                                             <h1 style="font-size:24px;margin:0 0 20px 0;font-family:Arial,sans-serif;">'+cTitulo+'</h1>
_cMsgMail += '                                             <p style="margin:0 0 12px 0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;">'+_cAviso+'</p>
_cMsgMail += '                                             <p style="margin:0 0 12px 0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;">'+_DataProx+'</p>
_cMsgMail += '                                             <p style="margin:0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;"><a href="http://portal.medmais.com:8007" style="color:#ee4c50;text-decoration:underline;">Abrir chamado para calibração</a></p>
_cMsgMail += '                                          </td>
_cMsgMail += '                                       </tr>
_cMsgMail += '                                    </table>
_cMsgMail += '                                  </td>
_cMsgMail += '                               </tr>
_cMsgMail += '                               <tr>
_cMsgMail += '                                  <td style="padding:30px;background:#B81330;">
_cMsgMail += '                                    <table role="presentation" style="width:100%;border-collapse:collapse;border:0;border-spacing:0;font-size:9px;font-family:Arial,sans-serif;">
_cMsgMail += '                                       <tr>
_cMsgMail += '                                          <td style="padding:0;width:50%;" align="left">
_cMsgMail += '                                            <p style="margin:0;font-size:14px;line-height:16px;font-family:Arial,sans-serif;color:#ffffff;">
_cMsgMail += '                                              &reg; COPYRIGHT, Grupo Med+ 2022<br/><a href="https://www.medmais.com" style="color:#ffffff;text-decoration:underline;">Site Grupo Med+</a>
_cMsgMail += '                                            </p>
_cMsgMail += '                                          </td>
_cMsgMail += '                                          <td style="padding:0;width:50%;" align="right">
_cMsgMail += '                                            <table role="presentation" style="border-collapse:collapse;border:0;border-spacing:0;">
_cMsgMail += '                                               <tr>
_cMsgMail += '                                                 <td style="padding:0 0 0 10px;width:38px;">
_cMsgMail += '                                                   <a href="https://www.instagram.com/grupomedmais/" style="color:#ffffff;"><img src="https://i.ibb.co/jgWML4Y/Pngtree-instagram-white-icon-free-logo-3570433.png" alt="Instragram" width="38" style="height:auto;display:block;border:0;" /></a>
_cMsgMail += '                                                 </td>
_cMsgMail += '                                                 <td style="padding:0 0 0 10px;width:38px;">
_cMsgMail += '                                                   <a href="https://www.linkedin.com/company/grupomedmais" style="color:#ffffff;"><img src="https://i.ibb.co/YZfZbN7/Pngtree-linkedin-white-icon-3570423.png" alt="Linkedin" width="38" style="height:auto;display:block;border:0;" /></a>
_cMsgMail += '                                                 </td>
_cMsgMail += '                                               </tr>
_cMsgMail += '                                            </table>
_cMsgMail += '                                          </td>
_cMsgMail += '                                       </tr>
_cMsgMail += '                                     </table>
_cMsgMail += '                                  </td>
_cMsgMail += '                               </tr>
_cMsgMail += '                             </table>
_cMsgMail += '                           </td>
_cMsgMail += '                        </tr>
_cMsgMail += '                    </table>
_cMsgMail += '                </td>
_cMsgMail += '              </tr>
_cMsgMail += '            </table>
_cMsgMail += '        </body>
_cMsgMail += '    </html> 


    U_MMSDEMAIL(_cMail, "calibração de Equipamentos", _cMsgMail ,, .F., ,, )

Return 



