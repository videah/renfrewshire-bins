import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class BrownHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Brown Bin"),
      ),
      body: ListView(
        children: <Widget>[
          Image.network("http://www.renfrewshire.gov.uk/image/7875/your-brown-bin/defaultheaderimage.jpg?m=1542126677433"),
          HtmlWidget(
              '''<div class="left">
            <div class="contenthead">
      </div>
      <div class="intro">
      <p>Here's an indicative list of what can and cannot go in your brown bin.</p>
      </div>
      <div class="textblock"><p>✔ Grass cuttings&nbsp;<br>✔&nbsp;Flowers and plants<br>✔&nbsp;Weeds<br>✔&nbsp;Leaves<br>✔&nbsp;Small branches and twigs<br>✔&nbsp;Cooked and uncooked food<br>✔&nbsp;Leftovers<br>✔&nbsp;Fruit and vegetable peelings<br>✔&nbsp;Tea bags and coffee grounds<br>✔&nbsp;Egg shells<br>✔&nbsp;Out of date food (remove packaging)<br>✔&nbsp;Bread, pasta and cakes<br>✔&nbsp;Meat, fish and small bones</p><p>✘&nbsp;Plastic bags<br>✘&nbsp;Packaging<br>✘&nbsp;Liquids<br>✘&nbsp;Fats and oils<br>✘ Rubble and soil<br>✘&nbsp;Plant pots<br>✘&nbsp;Wood and fencing<br>✘&nbsp;Garden furniture<br>✘&nbsp;Plastics, cans and glass<br>✘&nbsp;Paper, card and cardboard</p><p><strong>Guidance for your brown bin</strong></p><ul><li>Only use the special recyclable food waste liners we provide, or put food directly into the bin. Don't put your food waste in plastic bags.</li><li>Remove all packaging.</li><li>Don't put liquids (hot or cold) into your brown bin.</li><li>If the wrong material is in your brown bin, we cannot empty it as it will contaminate the whole vehicle load.&nbsp;</li><li>Please use your brown bin to recycle as much food and garden waste as you can.</li></ul><p><strong>Small food waste caddy</strong></p><ol><li>Put one of the free liners into your indoor food waste caddy.</li><li>Put any cooked or uncooked food waste into the bin.</li><li>When the liner is almost full, tie it and remove from the bin, replacing with a new liner.</li><li><strong>Place the filled liner in your brown bin.</strong></li><li>Place your brown bin at the kerbside on your collection day.</li></ol><p>Need more liners? Please tie one liner to the handle of your brown bin and the collection crew will leave you a new roll. You can put food waste directly into your brown bin if you want to do so.</p><p><strong>Brown Bin Collections FAQs</strong></p><p><strong>I do not use a brown bin at the moment—what do I do?</strong></p><p>If you are on a brown bin route but do not have a brown bin, please contact us on 0300 300 0300 or email <a href="mailto:mybins@renfrewshire.gov.uk">mybins@renfrewshire.gov.uk</a>&nbsp;and we will get one to you.</p><p>If you are not on a brown bin route there is no change to your service.</p><p>If you're not sure what route you are on, you can email <a href="mailto:mybins@renfrewshire.gov.uk">mybins@renfrewshire.gov.uk</a></p><p><strong>When will my brown bin be emptied?</strong></p><p>Your brown bin will be emptied on your normal collection day as per your calendar.</p><p><strong>Why does my bin need to be out by 7am?</strong></p><p>We collect bins between 7am and 6:30pm and your&nbsp;bin might not be emptied at the same time on each collection day so you must put it out for collection at 7am.</p><p><strong>What happens if my bin is contaminated?</strong></p><p>If your bin is contaminated with items that can't be recycled, a contamination sticker will be attached and it will not be emptied. If you remove the contaminants, the bin will be emptied on your next scheduled collection day.</p><p><strong>Why should my bin lid be closed?</strong></p><p>Closing the lid minimises odour, deters vermin, prevents litter and protects the health and safety of our collection crews.</p><p><strong>Does my assisted collection apply to this bin?</strong></p><p>Yes, if you have an assisted collection, this applies to your brown bin too.</p><p><strong>Why should I recycle food waste?</strong></p><p>Around a&nbsp;third of the waste in an average Scottish bin is food. Collecting food waste for recycling stops it from going to landfill and means that it can be turned into compost. All the food we collect is taken to a composting plant.</p><p>Putting food waste in the brown bin makes it is easier and more efficient to collect the same type of material in the same containers on the same route with the same vehicle.</p><p><strong>I have an old green food waste bin, what should I do with it?</strong></p><p>You can keep it and choose to use it how you wish. Some people choose to use them to transport their food waste to their brown bin.</p>
    </div>
    </div>'''
          ),
        ],
      )
    );
  }
}
