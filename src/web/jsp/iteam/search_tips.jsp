<b>Simple Query Syntax</b>
<br />
<br />
<table bgcolor="#DEDEDE" border="0" cellspacing="1" cellpadding="4" width="100%">
  <tr>
    <td><b>Search for project data by typing in words</b></td>
  </tr>
  <tr>
    <td>fall campaign</td>
  </tr>
  <tr>
    <td><hr color="#BFBFBB" noshade></td>
  </tr>
  <tr>
    <td><b>Search for exact phrases by using quotations</b></td>
  </tr>
  <tr>
    <td>"fall campaign"</td>
  </tr>
  <tr>
    <td><hr color="#BFBFBB" noshade></td>
  </tr>
  <tr>
    <td><b>Use AND, OR, NOT operators when searching</b></td>
  </tr>
  <tr>
    <td>campaign NOT fall<br />
	    &quot;fall campaign&quot; AND &quot;campaign ideas&quot;<br />
      &quot;fall campaign&quot; OR ideas<br />
      <br />
      Note: AND, OR, NOT can be uppercase or lowercase.
    </td>
  </tr>
  <tr>
    <td><hr color="#BFBFBB" noshade></td>
  </tr>
  <tr>
    <td><b>Search using single and multiple character wildcard searches</b></td>
  </tr>
  <tr>
    <td>
      To perform a single character wildcard search use the &quot;?&quot; symbol:<br />
      <br />
      cam?aign<br />
      <br />
      To perform a multiple character wildcard search use the &quot;*&quot; symbol:<br />
      <br />
      ca*gn<br />
      campaign*<br />
      <br />
      Note: You cannot use a * or ? symbol as the first character of a search.
    </td>
  </tr>
  <tr>
</table>
<br />
<br />
<b>Advanced Query Syntax</b>
<br />
<br />
<table bgcolor="#DEDEDE" border="0" cellspacing="1" cellpadding="4" width="100%">
  <tr>
    <td><b>Fuzzy Search</b></td>
  </tr>
  <tr>
    <td>To do a fuzzy search, use the tilde &quot;~&quot; symbol at the end of a single word term. 
      For example, to search for a term similar in spelling to &quot;roam&quot;, use the search:<br />
        <br />
        roam~<br />
        <br />
        This search will find terms like foam and roams.
    </td>
  </tr>
  <tr>
    <td><hr color="#BFBFBB" noshade></td>
  </tr>
  <tr>
    <td><b>Proximity Search</b></td>
  </tr>
  <tr>
    <td>To do a proximity search, use the tilde &quot;~&quot; symbol at the end of a phrase.
      For example, to search for &quot;fall&quot; and &quot;campaign&quot; within 10 words of
      each other in a document, use the search:<br />
      <br />
	    &quot;fall campaign&quot;~10
    </td>
  </tr>
</table>
<br />
<input type="button" value="Close" onClick="window.close()" />
