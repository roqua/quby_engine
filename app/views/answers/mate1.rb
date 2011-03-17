key "mate1"
title "MATE 1. Middelen: Gebruik"

css "#content .paged .panel .item.radio .option, #content .paged .panel .item.check_box .option,
  #content .paged .panel .item.horizontal .description-and-fields, 
  #content .paged .panel .item .description-and-fields div.description,
  #content .paged .panel .item .description-and-fields .fields,
  #content .paged .panel .item .description-and-fields,
  #content .paged .panel .item { 
    width: auto;
  }
  "

allow_hotkeys :none 

panel do

  raw_html "<table width='100%' border='1' bordercolor='#000000' cellpadding=
    '4' cellspacing='0'>
      <col width='36*'>
      <col width='71*'>
      <col width='29*'>
      <col width='35*'>
      <col width='43*'>
      <col width='25*'>
      <col width='18*'>"
  question :v_00, :type => :check_box, :raw_content => "
      <tr valign='top'>
        <td colspan='2' width='42%' height='27'>
        <div class='check_box item'>
            <div class='description-and-fields'>
              <div class='description'>
              </div>
              <div id='answer_v_00_input' class='fields'>
                <div class='option'>
                  <div class='radiocheckwrapper'>
                    <input type='hidden' value='0' name='answer[v_00_a01]'><input type='checkbox' value='1' name='answer[v_00_a01]' id='answer_v_00_a01' >
                  </div>
                  <label for='answer_v_00_a01' align='right'>
                  †Kruis hier aan als u
                  niet het gebruik van de afgelopen 30 dagen invult, maar van
                  een eerdere periode van 30 dagen.</label>
                </div>                
              </div>
            </div>
          </div>
        </td>" do 
    option :v_00_a01, :description => "een eerdere periode van 30 dagen"
  end
        

  raw_html "
        <td colspan='3' width='41%'>
          <p align='center'><b>Laatste 30 dagen</b></p>
        </td>
  
        <td colspan='2' width='17%'>
          <p align='center'><b>Het hele leven</b></p>
        </td>
      </tr>
  
      <tr valign='top'>
        <td rowspan='2' colspan='2' width='42%'>
          <p align='right'><i>&#171;Ik begin met een schema,
          waarin de middelen die u zou kunnen gebruiken, nagevraagd
          worden. Dit gaat over 2 periodes: de laatste 30 dagen en
          het hele leven. Voor het hele leven willen we graag weten
          hoeveel jaren u dat middel regelmatig gebruikte. Voor de
          laatste 30 dagen willen we weten hoeveel dagen u het middel
          gebruikte en hoeveel u dan gebruikte.</i></p>
  
          <p align='right'><i>&#171;Ik begin met alcohol. Heeft
          u de afgelopen 30 dagen alcohol gedronken? Zo ja, hoevaak
          en hoeveel dronk u op een dag?</i></p>
  
          <p align='right'>
          <i>†Ga zo verder voor
          de andere middelen.</i></p>
        </td>
  
        <td width='11%'>
          <p align='center'><b>Aantal dagen</b> gebruikt in de
          laatste 30 dagen</p>
        </td>
  
        <td colspan='2' width='30%'>
          <p align='center'><b>Hoeveelheid</b> op een
          <b>kenmerkende</b> gebruiksdag</p>
        </td>
  
        <td colspan='2' width='17%'>
          <p align='center'>Totaal aantal jaren regelmatig
          gebruik</p>
        </td>
      </tr>
  
      <tr valign='top'>
        <td width='11%'>
          <p align='right'>†Vul
          het aantal gebruiksdagen in (Iedere dag is 30;
          één keer in de week is 4 enz. Als er
          geen gebruiksdagen zijn geweest, vul dan 0 in.)</p>
        </td>
  
        <td width='13%'>
          <p align='right'>†Vul
          het aantal glazen, sigaretten, grammen of pillen in van een
          kenmerkende gebruiksdag.</p>
        </td>
  
        <td width='17%'>
          <p align='right'>†Bij
          alcohol, nicotine, gokken: standaardeenheid, bij andere
          stoffen kies de gebruikte eenheid.</p>
        </td>
  
        <td colspan='2' width='17%'>
          <p align='right'>†NB:
          Deze kolom altijd invullen, ook als de stof nooit is
          gebruikt: vul dan een 0 in.</p>
  
          <p align='right'>†Bij
          minder dan een jaar: vul in 0,25 (3 maanden) of 0,5 (half
          jaar) of 0,75 (9 maanden).</p>
        </td>
      </tr>"
  
  question :v_01, :type => :integer, :raw_content => "
  <tr valign='top'>
        <td rowspan='2' width='14%'>
          <p>Alcohol</p>
        </td>
  
        <td width='28%'>
          <p align='right'>Gewoonlijk gebruik</p>
        </td>
  
        <td width='11%'>
          <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_01_input' class='fields'>
                  <input type='text' size='4' name='answer[v_01]' id='answer_v_01' class='' autocomplete='off'>
                </div>
              </div>
            </div>        </td>
  " do
    
    end
  
  question :v_02, :type => :integer, :raw_content => "
    <td width='13%'>
          <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_02_input' class='fields'>
                  <input type='text' size='4' name='answer[v_02]' id='answer_v_02' class='' autocomplete='off'>
                </div>
              </div>
            </div>        </td>
  " do 
  end
  
  raw_html "<td rowspan='2' width='17%'>
          <p align='center'>standaardglazen (van ca. 10 gram
          alcohol)</p>
        </td>"
  
  question :v_03, :type => :float, :raw_content => "
    <td rowspan='2' width='10%'>
          <div class='horizontal integer item'>
            <div class='error valid_float hidden'>Deze vraag moet met een getal beantwoord worden, gebruik een punt . als scheidingsteken</div>
              <div class='description-and-fields'>
                <div id='answer_v_03_input' class='fields'>
                  <input type='text' size='4' name='answer[v_03]' id='answer_v_03' class='' autocomplete='off'>
                </div>
              </div>
            </div>        </td>
  
        <td rowspan='2' width='7%'>
          <p class='sideways-table'>Standaardglazen per week: man
          &gt;28; vrouw &gt; 21</p>
        </td>
      </tr>
  " do 
  end
  
  question :v_04, :type => :integer, :raw_content => "
    <tr valign='top'>
      <td width='28%'>
        <span>†Hoger gebruik:
        alleen invullen als sprake is van afwisselend gebruik in de
        afgelopen 30 dagen, Hoger zoals bijvoorbeeld bij veel hoger
        gebruik gebruik in het weekend dan door de week.<br>
        <br></span>

        <p align='right'><span>Hoger Gebruik</span></p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_04_input' class='fields'>
                  <input type='text' size='4' name='answer[v_04]' id='answer_v_04' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
  " do 
  end
  
  question :v_05, :type => :integer, :raw_content => "
  <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_05_input' class='fields'>
                  <input type='text' size='4' name='answer[v_05]' id='answer_v_05' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    
  question :v_06, :type => :integer, :raw_content => "
  <tr valign='top'>
      <td width='14%'>
        <p>Nicotine</p>
      </td>

      <td width='28%'>
        <p>Sigaretten, shag, sigaren, pijp, snuif/pruimtabak</p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_06_input' class='fields'>
                  <input type='text' size='4' name='answer[v_06]' id='answer_v_06' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
  "
  
  question :v_07, :type => :integer, :raw_content => "
  <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_07_input' class='fields'>
                  <input type='text' size='4' name='answer[v_07]' id='answer_v_07' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
      
  question :v_08, :type => :integer, :raw_content => "
  <td width='17%'>
        <p align='center'>sigaretten (of sjekkies, sigaren
        etc.)</p>
      </td>

      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_08_input' class='fields'>
                  <input type='text' size='4' name='answer[v_08]' id='answer_v_08' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>  

      <td width='7%'>
        <p class='sideways-table'>Dagelijks</p>
      </td>
    </tr>"
  
  question :v_09, :type => :integer, :raw_content => "
  <tr valign='top'>
      <td width='14%'>
        <p>Cannabis</p>
      </td>

      <td width='28%'>
        <p>Hasjiesj, Marihuana, Weed</p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_09_input' class='fields'>
                  <input type='text' size='4' name='answer[v_09]' id='answer_v_09' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
      
  question :v_10, :type => :integer, :raw_content => "
      <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_10_input' class='fields'>
                  <input type='text' size='4' name='answer[v_10]' id='answer_v_10' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
  question :v_11, :type => :select, :raw_content => "    
      <td width='17%'>
        <div class='item select'>
            <div class='description-and-fields'>
              <div id='answer_v_11_input' class='fields'>
                <select name='answer[v_11]'>
                  <option value='a1' hides='[]' class='' allhidden='[]'>
                    gram
                  </option>
                  <option value='a2' hides='[]' class='' allhidden='[]'>
                    joints
                  </option>
                  <option value='a3' hides='[]' class='' allhidden='[]'>
                    stickies
                  </option>
                </select>
              </div>
            </div>
          </div>
      </td>
      "do
        option :a1, :value => 1, :description => "gram"
        option :a2, :value => 2, :description => "joints"
        option :a3, :value => 3, :description => "stickies"
      end
  question :v_12, :type => :integer, :raw_content => "
      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_12_input' class='fields'>
                  <input type='text' size='4' name='answer[v_12]' id='answer_v_12' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>

      <td rowspan='11' width='7%'>
        <p align='center'>Regelmatig gebruik
        betekent: Wekelijks (1 of meer keer per week)</p>
      </td>
    </tr>"
    
  question :v_13, :type => :integer, :raw_content => "
  <tr valign='top'>
      <td rowspan='3' width='14%' height='18'>
        <p>Opiaten</p>
      </td>

      <td width='28%'>
        <p>Methadon</p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_13_input' class='fields'>
                  <input type='text' size='4' name='answer[v_13]' id='answer_v_13' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
      
  question :v_14, :type => :integer, :raw_content => "
      <td width='13%'>
         <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_14_input' class='fields'>
                  <input type='text' size='4' name='answer[v_14]' id='answer_v_14' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
  question :v_15, :type => :select, :raw_content => "
      <td width='17%'>
        <div class='item select'>
            <div class='description-and-fields'>
              <div id='answer_v_15_input' class='fields'>
                <select name='answer[v_15]'>
                  <option value='a1' hides='[]' class='' allhidden='[]'>
                    mg
                  </option>
                  <option value='a2' hides='[]' class='' allhidden='[]'>
                    pillen
                  </option>
                </select>
              </div>
            </div>
          </div>
      </td>" do
        option :a1, :value => 1, :description => "mg"
        option :a2, :value => 2, :description => "pillen"
      end
  question :v_16, :type => :integer, :raw_content => "
      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_16_input' class='fields'>
                  <input type='text' size='4' name='answer[v_16]' id='answer_v_16' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"

  question :v_17, :type => :integer, :raw_content => "
    <tr valign='top'>
      <td width='28%'>
        <p>Heroïne</p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_17_input' class='fields'>
                  <input type='text' size='4' name='answer[v_17]' id='answer_v_17' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
  
  question :v_18, :type => :integer, :raw_content => "
      <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_18_input' class='fields'>
                  <input type='text' size='4' name='answer[v_18]' id='answer_v_18' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
  
  question :v_19, :type => :select, :raw_content => "
      <td width='17%'>
      <div class='item select'>
            <div class='description-and-fields'>
              <div id='answer_v_19_input' class='fields'>
                <select name='answer[v_19]'>
                  <option value='a1' hides='[]' class='' allhidden='[]'>
                    gram
                  </option>
                  <option value='a2' hides='[]' class='' allhidden='[]'>
                    shots
                  </option>
                  <option value='a3' hides='[]' class='' allhidden='[]'>
                    roken
                  </option>
                  <option value='a4' hides='[]' class='' allhidden='[]'>
                    snuifjes
                  </option>
                </select>
              </div>
            </div>
          </div>
      </td>" do
        option :a1, :value => 1, :description => "gram"
        option :a2, :value => 2, :description => "shots"
        option :a3, :value => 3, :description => "roken"
        option :a4, :value => 4, :description => "snuifjes"
      end
  question :v_20, :type => :integer, :raw_content => "
      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_20_input' class='fields'>
                  <input type='text' size='4' name='answer[v_20]' id='answer_v_20' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    
  question :v_21, :type => :integer, :raw_content => "
    <tr valign='top'>
      <td width='28%'>
        <p>Overige opiaten zoals Codeïne, Darvon,
        Demerol, Dilaudid, Morfine, MSContin, Opium, Palfium,
        Percodan</p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_21_input' class='fields'>
                  <input type='text' size='4' name='answer[v_21]' id='answer_v_21' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_22, :type => :integer, :raw_content => "
      <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_22_input' class='fields'>
                  <input type='text' size='4' name='answer[v_22]' id='answer_v_22' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
      
    question :v_23, :type => :select, :raw_content => "
      <td width='17%'>
      <div class='item select'>
            <div class='description-and-fields'>
              <div id='answer_v_23_input' class='fields'>
                <select name='answer[v_23]'>
                  <option value='a1' hides='[]' class='' allhidden='[]'>
                    gram
                  </option>
                  <option value='a2' hides='[]' class='' allhidden='[]'>
                    shots
                  </option>
                  <option value='a3' hides='[]' class='' allhidden='[]'>
                    roken
                  </option>
                  <option value='a4' hides='[]' class='' allhidden='[]'>
                    snuifjes
                  </option>
                  <option value='a5' hides='[]' class='' allhidden='[]'>
                    pillen
                  </option>
                </select>
              </div>
            </div>
          </div>
      </td>" do
        option :a1, :value => 1, :description => "gram"
        option :a2, :value => 2, :description => "shots"
        option :a3, :value => 3, :description => "roken"
        option :a4, :value => 4, :description => "snuifjes"
        option :a5, :value => 5, :description => "pillen"
      end
    question :v_24, :type => :integer, :raw_content => "
      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_24_input' class='fields'>
                  <input type='text' size='4' name='answer[v_24]' id='answer_v_24' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    question :v_25, :type => :integer, :raw_content => "<tr valign='top'>
      <td rowspan='2' width='14%' height='14'>
        <p>Cocaïne</p>
      </td>

      <td width='28%'>
        <p>Crack, gekookte (base) coke</p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_25_input' class='fields'>
                  <input type='text' size='4' name='answer[v_25]' id='answer_v_25' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_26, :type => :integer, :raw_content => "
    <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_26_input' class='fields'>
                  <input type='text' size='4' name='answer[v_26]' id='answer_v_26' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_27, :type => :select, :raw_content => "
      <td width='17%'>
      <div class='item select'>
            <div class='description-and-fields'>
              <div id='answer_v_27_input' class='fields'>
                <select name='answer[v_27]'>
                  <option value='a1' hides='[]' class='' allhidden='[]'>
                    gram
                  </option>
                  <option value='a2' hides='[]' class='' allhidden='[]'>
                    pijpjes
                  </option>
                </select>
              </div>
            </div>
          </div>
      </td>" do
        option :a1, :value => 1, :description => "gram"
        option :a2, :value => 2, :description => "pijpjes"
      end
    question :v_28, :type => :integer, :raw_content => "
      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_28_input' class='fields'>
                  <input type='text' size='4' name='answer[v_28]' id='answer_v_28' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    question :v_29, :type => :integer, :raw_content => "
    <tr valign='top'>
      <td width='28%'>
        <p>Cocaïne, snuifcoke</p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_29_input' class='fields'>
                  <input type='text' size='4' name='answer[v_29]' id='answer_v_29' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_30, :type => :integer, :raw_content => "
    <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_30_input' class='fields'>
                  <input type='text' size='4' name='answer[v_30]' id='answer_v_30' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_31, :type => :select, :raw_content => "
      <td width='17%'>
      <div class='item select'>
            <div class='description-and-fields'>
              <div id='answer_v_31_input' class='fields'>
                <select name='answer[v_31]'>
                  <option value='a1' hides='[]' class='' allhidden='[]'>
                    gram
                  </option>
                  <option value='a2' hides='[]' class='' allhidden='[]'>
                    shots
                  </option>
                  <option value='a3' hides='[]' class='' allhidden='[]'>
                    roken
                  </option>
                  <option value='a4' hides='[]' class='' allhidden='[]'>
                    snuifjes
                  </option>
                </select>
              </div>
            </div>
          </div>
      </td>" do
        option :a1, :value => 1, :description => "gram"
        option :a2, :value => 2, :description => "wikkels"
        option :a3, :value => 3, :description => "snuifjes"
        option :a4, :value => 4, :description => "shots"
      end
    question :v_32, :type => :integer, :raw_content => "
      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_32_input' class='fields'>
                  <input type='text' size='4' name='answer[v_32]' id='answer_v_32' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    question :v_33, :type => :integer, :raw_content => "
    <tr valign='top'>
      <td width='14%'>
        <p>Stimulantia</p>
      </td>

      <td width='28%'>
        <p>Amfetamines, Khat, Pepmiddelen, Ponderal, Ritaline,
        Speed</p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_33_input' class='fields'>
                  <input type='text' size='4' name='answer[v_33]' id='answer_v_33' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_34, :type => :integer, :raw_content => "
    <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_31_input' class='fields'>
                  <input type='text' size='4' name='answer[v_34]' id='answer_v_34' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_35, :type => :select, :raw_content => "
      <td width='17%'>
      <div class='item select'>
            <div class='description-and-fields'>
              <div id='answer_v_35_input' class='fields'>
                <select name='answer[v_35]'>
                  <option value='a1' hides='[]' class='' allhidden='[]'>
                    gram
                  </option>
                  <option value='a2' hides='[]' class='' allhidden='[]'>
                    pillen
                  </option>
                  <option value='a3' hides='[]' class='' allhidden='[]'>
                    snuifjes
                  </option>
                  <option value='a4' hides='[]' class='' allhidden='[]'>
                    shots
                  </option>
                  <option value='a5' hides='[]' class='' allhidden='[]'>
                    pijpjes
                  </option>
                </select>
              </div>
            </div>
          </div>
      </td>" do
        option :a1, :value => 1, :description => "gram"
        option :a2, :value => 2, :description => "pillen"
        option :a3, :value => 3, :description => "snuifjes"
        option :a4, :value => 4, :description => "shots"
        option :a5, :value => 5, :description => "pijpjes"
      end
    question :v_36, :type => :integer, :raw_content => "
      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_36_input' class='fields'>
                  <input type='text' size='4' name='answer[v_36]' id='answer_v_36' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    question :v_37, :type => :integer, :raw_content => "
    <tr valign='top'>
      <td width='14%'>
        <p>Ecstacy/XTC</p>
      </td>

      <td width='28%'>
        <p>MDMA of andere psychedelische amfetaminen zoals MDEA,
        MDA of 2CB</p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_37_input' class='fields'>
                  <input type='text' size='4' name='answer[v_37]' id='answer_v_37' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_38, :type => :integer, :raw_content => "
    <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_38_input' class='fields'>
                  <input type='text' size='4' name='answer[v_38]' id='answer_v_38' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_39, :type => :select, :raw_content => "
      <td width='17%'>
      <div class='item select'>
            <div class='description-and-fields'>
              <div id='answer_v_39_input' class='fields'>
                <select name='answer[v_39]'>
                  <option value='a1' hides='[]' class='' allhidden='[]'>
                    mg
                  </option>
                  <option value='a2' hides='[]' class='' allhidden='[]'>
                    pillen
                  </option>
                </select>
              </div>
            </div>
          </div>
      </td>" do
        option :a1, :value => 1, :description => "mg"
        option :a2, :value => 2, :description => "pillen"
      end
    question :v_40, :type => :integer, :raw_content => "
      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_40_input' class='fields'>
                  <input type='text' size='4' name='answer[v_40]' id='answer_v_40' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    question :v_41, :type => :string, :raw_content => "
    <tr valign='top'>
      <td width='14%'>
        <p>Andere middelen (drugs)</p>
      </td>

      <td width='28%'>
        <p>Bijvoorbeeld: Psychedelica, Inhalantia, Popper.
        Omschrijf:
        <div class='horizontal string item'>
              <div class='description-and-fields'>
                <div id='answer_v_41_input' class='fields'>
                  <input type='text' size='11' name='answer[v_41]' id='answer_v_41' class='' autocomplete='off'>
                </div>
              </div>
            </div></p>
      </td>"
    
    question :v_42, :type => :integer, :raw_content => "
    <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_42_input' class='fields'>
                  <input type='text' size='4' name='answer[v_42]' id='answer_v_42' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_43, :type => :integer, :raw_content => "
    <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_43_input' class='fields'>
                  <input type='text' size='4' name='answer[v_43]' id='answer_v_43' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_44, :type => :select, :raw_content => "
      <td width='17%'>
        <div class='item select'>
            <div class='description-and-fields'>
              <div id='answer_v_44_input' class='fields'>
                <select name='answer[v_44]'>
                  <option value='a1' hides='[]' class='' allhidden='[]'>
                    mg
                  </option>
                  <option value='a2' hides='[]' class='' allhidden='[]'>
                    gram
                  </option>
                </select>
              </div>
            </div>
          </div>
      </td>" do
        option :a1, :value => 1, :description => "mg"
        option :a2, :value => 2, :description => "gram"
      end
      
    question :v_45, :type => :integer, :raw_content => "
      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_45_input' class='fields'>
                  <input type='text' size='4' name='answer[v_45]' id='answer_v_45' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    question :v_46, :type => :integer, :raw_content => "
    <tr valign='top'>
      <td width='14%'>
        <p>Sedativa</p>
      </td>

      <td width='28%'>
        <p>Barbituraten, kalmerings- slaapmiddelen, tranquilizers,
        bv. Dalmadorm, Librium, Mogadon, Normison, Rohypnol,
        Seresta, Temesta, Valium, Xanax</p>
      </td>

      <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_46_input' class='fields'>
                  <input type='text' size='4' name='answer[v_46]' id='answer_v_46' class='' autocomplete='off'>
                </div>
              </div>
            </div></td>"
    question :v_47, :type => :integer, :raw_content => "
    <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_47_input' class='fields'>
                  <input type='text' size='4' name='answer[v_47]' id='answer_v_47' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_48, :type => :select, :raw_content => "
      <td width='17%'>
      <div class='item select'>
            <div class='description-and-fields'>
              <div id='answer_v_48_input' class='fields'>
                <select name='answer[v_48]'>
                  <option value='a1' hides='[]' class='' allhidden='[]'>
                    mg
                  </option>
                  <option value='a2' hides='[]' class='' allhidden='[]'>
                    pillen
                  </option>
                </select>
              </div>
            </div>
          </div>
      </td>" do
        option :a1, :value => 1, :description => "mg"
        option :a2, :value => 2, :description => "pillen"
      end
      
    question :v_49, :type => :integer, :raw_content => "
      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_49_input' class='fields'>
                  <input type='text' size='4' name='answer[v_49]' id='answer_v_49' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    question :v_50, :type => :string, :raw_content => "
    <tr valign='top'>
      <td width='14%'>
        <p>Gokken</p>
      </td>

      <td width='28%'>
        <p>Waarop of waarmee gegokt:
         <div class='horizontal string item'>
            <div class='description-and-fields'>
                <div id='answer_v_50_input' class='fields'>
                  <input type='text' size='11' name='answer[v_50]' id='answer_v_50' class='' autocomplete='off'>
                </div>
              </div>
            </div>
        </p>
      </td>"
    question :v_51, :type => :integer, :raw_content => "
    <td width='11%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_51_input' class='fields'>
                  <input type='text' size='4' name='answer[v_51]' id='answer_v_51' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_52, :type => :integer, :raw_content => "
    <td width='13%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_52_input' class='fields'>
                  <input type='text' size='4' name='answer[v_52]' id='answer_v_52' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>"
    question :v_53, :type => :integer, :raw_content => "
    <td width='17%'>
        <p align='center'>euro's uitgegeven
        (bruto)</p>
      </td>

      <td width='10%'>
        <div class='horizontal integer item'>
            <div class='error valid_integer hidden'>Deze vraag moet met een geheel getal beantwoord worden.</div>
              <div class='description-and-fields'>
                <div id='answer_v_53_input' class='fields'>
                  <input type='text' size='4' name='answer[v_53]' id='answer_v_53' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    question :v_54, :type => :radio, :raw_content => "
    <tr valign='top'>
      <td colspan='2' width='42%'>
        <p align='right'><i>&#171;Heeft u ooit middelen
        gespoten?</i></p>
      </td>

      <td colspan='5' width='58%'>
        <div class='scale item'>
            <div class='description-and-fields'>
              <div id='answer_v_54_input' class='fields'>
                <table cellspacing='0' border='0'>
                <tbody><tr>
                  <td class='option'>
                    <input type='radio' value='a01' name='answer[v_54]' id='answer_v_54_a01'>
                    <label for='answer_v_54_a01'>
                        <p>Ooit gespoten</p>
                    </label>
                  </td>
                <td class='option'>
                    <input type='radio' value='a02' name='answer[v_54]' id='answer_v_54_a02'>
                    <label for='answer_v_54_a02'>
                        <p>Spuit nog</p>
                    </label>
                </td>
                <td class='option'>
                    <input type='radio' value='a03' name='answer[v_54]' id='answer_v_54_a03'>
                    <label for='answer_v_54_a03'>
                        <p>Nooit gespoten</p>
                    </label>
                </td>
              </tr>
            </tbody></table>
         </div>
      </td>
    </tr>" do
      option :a01, :value => 1, :description => "Ooit gespoten"
      option :a02, :value => 2, :description => "Spuit nog"
      option :a03, :value => 3, :description => "Nooit gespoten"
    end
    
    question :v_55, :type => :string, :raw_content => "
    <tr>
      <td colspan='7' width='100%' valign='top'>
        <p align='right'>
        †<i>De Primaire
        Probleemstof is de stof waarvan het gebruik door de persoon
        en de beoordelaar als het meest problemen veroorzakend
        wordt ervaren. Als dit onduidelijkheden oplevert, kies dan
        in de volgorde (1) Cocaïne, (2) Opiaten, (3)
        Alcohol, (4) Overige drugs en sedativa, (5) Cannabis, (6)
        Gokken of nicotine. Als nicotinegebruik of gokken de
        aanmeldklacht is, dan is nicotine of gokken ook de
        probleem(stof).</i></p>
      </td>
    </tr>

    <tr valign='top'>
      <td colspan='2' width='42%'>
        <p align='right'>
        <i>[--middel--][Primaire Probleemstof/Probleem] =</i></p>
      </td>

      <td colspan='5' width='58%'>
         <div class='horizontal string item'>
            <div class='description-and-fields'>
                <div id='answer_v_55_input' class='fields'>
                  <input type='text' size='24' name='answer[v_55]' id='answer_v_55' class='' autocomplete='off'>
                </div>
              </div>
            </div>
      </td>
    </tr>"
    raw_html "</table>"
    question :v_56, :type => :string, :raw_content => "
    <p> Overige opmerkingen (bv. uit de kantlijn):
    <div class='horizontal string item'>
      <div class='description-and-fields'>
        <div id='answer_v_56_input' class='fields'>
          <input type='text' size='40' name='answer[v_56]' id='answer_v_56' class='' autocomplete='off'></textarea>
        </div>
      </div>
    </div>
    </p>"
end