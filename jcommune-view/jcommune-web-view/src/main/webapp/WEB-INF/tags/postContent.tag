<%--

    Copyright (C) 2011  JTalks.org Team
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.
    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

--%>
<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag body-content="empty" %>
<%@ attribute name="text" required="true" type="java.lang.String" %>
<%@ attribute name="signature" required="false" type="java.lang.String" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="jtalks" uri="http://www.jtalks.org/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="word-wrap">
  <jtalks:bb2html bbCode="${text}"/>
  <div style="float: right;vertical-align: text-top">
    <img style="height:30px;width:30px;" src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBhANEA4PDg4QDQ4NEA4ODA0ODg8MDRMOFBIVFhgQExIXHCYeGBovGRUSHzEhIycqLCwtFR4xNTAqNyo3LCoBCQoKDgwOGg8PGjEkHyQpNSoxKTUvLC0sMDUqKS8sKTQvLCkpKSkpKTUsKTQpNCwpLCwpLC0sNTUsLCwsNSk0Kv/AABEIAMwAzAMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAAAgYDBQcBBP/EAEEQAAIBAgIGAwsKBgMAAAAAAAABAgMRBDEFBhIhQVEWYXMHExUkNFNUcZOy0RQXIjJCUmJygbEjM5KhotJDwfD/xAAaAQEAAwEBAQAAAAAAAAAAAAAAAwQFAgYB/8QAJxEBAAICAQMEAgIDAAAAAAAAAAECAxEEEhRxMTIzUSJSE0IhQWH/2gAMAwEAAhEDEQA/AO4gAAAAAAAAAAAABCrVUIylJ7MYpyk3kkuJMrGsmlVJyp3vSotOtb7dXONFfuyTHSb20iy5Ix13LyensVOW3SpwVLOFOf8AMlHm+TLBgMbGvTjUhk84vOMlnF9ZzKriZTltuT2r3TW63q5Fh0Dpnvcttu0JtRxK+7PKNZdTyZdzceOn8YZ+DlT16tP+JXQAGc1QAAAAAAAAAAAAAAAAAAAAAAAAAxYrExpQlUm9mME5Sf8A7iPUmdPi03pJ0IKMLd+q3jSTyS41H1Jf9HP8diVJqMW3CF7N5yk86j62z7tNaTlNylLdVrJXjf8Al0Ps0/W82aW5r4MXRDD5Ob+S3/ErmbC4nvcr22otOM4vKUHmj57i5YVXQdW9J7SVCUtpxjtYebe+dHl+ZZM3pzLRWMacYKWzKMtvDzf2an3X+F5M6FovSCxFNTS2Zb41IPONRZxZlcjF0z1Q2eJm669M+sPrABVXQAAAAAAAAAAAAAAAAAAAAAKhrJplTk0t9GhK1uFXELh1xjx6zb6w6TdKKpU5bNWqm9rzdJfWqP8AZdZz7HYpTaUN1OmtmmuNvvPreZd42Lf5SzuZn1+EMVSq5Nyk7yk7t9ZG5G4uaTKSuLkbi4Erll0Dpvvcu+t7vowxcfw5RrrrWTKxczYXEulJSW/hKLycXnFnF6RaNS7peaW3DrcZJpNb096ayselc1Y0ovo0HK8JRc8JJ5uCzpPrj+3qLGY16TSdS38eSMleqAAHCQAAAAAAAAAAAAAAAAPnx+Ohh6cqs39GKyWbfCK629x9BSNYtOKpLbTvSoyccNHhUrLc6v5Y5LrJcWPrtpBnyxjrv/bVaa0hKTmpP+LValXtvUY/ZorqSz6zT3PJTbbbd23dt5t8zy5s1jUaYNpm07lK4uRuLn18SuLkbi4Eri5G4uBstF4yzVNy2LyUqNTzdZZS9TyZ0bQ+kvlNO7WzUg9itD7tRZ/pxXrOT3LJoHTTptVd7dNKGKit7nQ4VEuMo/sVeRi643Hqt8XN/HbU+joQI06iklKLUoyScWt6aeTRIym2AAAAAAAAAAAAAAB8eldJRw1KVSS2nujTgs51HlBfqfYiZnUPkzERuWt1m0rsr5PCexKcXKvUX/HQ4v8AM8l+pz3G4vvsrpbMIrZpQ4RgskfZprHSblBy2qk5beKmsnU4U1+GK3Gpua+HHFKsHPlnJbaVxcjcXJ0CVxcjcXAlcXI3FwJXFyNxcCVzLhsTKlKM45xf6NcU+owXFz4Og6raWjHZo3/hVbywrf2ZZyoP1ZrqLScj0ZjFF97nJxhNpxms6dVfVqL9TpWgtKPEU2p2jXpPYrxWW1wmvwtb0ZvJxdM9UNfh5uqOiWyABTXwAAAAAAAAAAeN23vclm3kUHWHT3fJd+T+itqGCj/aWIa/sjc616WX0sOpbMFFTxk1mqfCkvxS/b1nPsbi3Wm5vctyhFZRgsoov8bF/aWXzM/9IYmxcjcXL7NSuLkbi4Eri5G4uBK4uRuLgSuLkbi4Eri5G4uBK5YtAaYlBxqK8qlCOzUhxq4biuuUc0Vu5koYiVOUZwdpRd0zm1YtGpdUtNZ3Ds2HrxqxjOElKE0pRksmmZCn6q6ZjFxp5UMQ33leaxGcqL6nmi4GPkpNLab+HLGSu4AARpQAAAAAAAFR0/qZVxFSpOlXjGFaUZzpzT+uo23NZo1XzcYjz1H/AD+B0MFivIvEahVtxMdp3MOdvucYjz1H/P4Gt01qrWwUI1KsqcoykoJQcm72b4pcjqxU+6P5NT7aPuyJcXIva8RKDNxcdKTaHO7i5G4uaLJSuLkbi4Eri5G4uBK4uRuLgSuZ8DhZV6lOlFpSqyUIuV7XfM+a5stWn45hO2gc2nUTLukbtEN183WK85Q/qn/qPm6xXnKH9U/9TowMzusjY7LEo2i9RcRTnHvlamqSnTqSUNqUnKErq10rcr9ZeQCK+S1/VPixVxxqoACNKAAAAAAAAAAAVLukeS0+2j7si2lS7pXktPto+7ImwfJCDk/FZzi4uRuLmu8+lcXI3FwJXFyNxcCVxcjcXAlc2WrXlmE7aBq7my1ZfjuE7aBzf2z4d4/fHl2QAGI9IAAAAAAAAAAAAAAAAFR7pfktPto+7ItxUO6Z5LT7aPuyJsHyQg5PxWc2uLkLntzXefSuLkbi4Eri5G4uBK4uRuLgSubPVh+O4TtoGqubPVfy3CdtA5v7Z8O8fvjy7OADEekAAAAAAAAAAAAAAAACn903yWl20fdkXAp/dP8AJaXbx92RNg+SEHJ+KzmdxcjcXNd59K4uRuLgSuLkbi4Eri5G4uBK5s9V347g+2gaq5tNVn47g+2gc39s+HeP3x5dqQCBiPSAAAAAAAAAAAAAAAABTu6h5JS7ePuyLiU3uo+SUu3j7siXD8kIOT8VnMbi5G4ubDz6VxcjcXAlcXI3FwJXFyNxcCVzaarPx7B9vA1Nzaaqvx7B9vA4v7Z8O8fvjy7cgEDFekAAAAAAAAADDXr7CuBmBpa2nFE+WprEBY7i5VqmsjMXSNgW7aRpNbdCfL8NKlGSjUjJVKTf1dpX3PqabRqJ6xSIdIZcz7W01ncObVi0TWVDxGrWMpScZYWrdcYwdSL6043Rj8B4r0Wv7Gp8DoHSGfMdIZ8y33c/Sh2Fftz7wJivRa/sZ/AeBMT6NX9lP4F9lp6b4kfDk+bPvdz9HYV/ZRPAmJ9Gr+yn8B4ExPo1f2U/gXvw5Pmx4cnzY7ufo7Cv7KJ4ExXotf2U/ge+A8V6LX9jP4F68OT5syR1gmuI7ufo7Cv7KD4DxXotf2M/gWrUnU2sq9PE4mDowovbpwluqSnwduC47+RtukM+Y6Qz5nF+Va0a07pwqVtuZ2um2uZ7tFLWsMuZlWsciqvLfc9uVGOsbM8dYwLOCv09YUzYYXSamBsAeJnoAxVqKmrMygDU1dCRkfNPV1M34ArM9WyD1aLTYWAqEtW2edG2W+wsBT3q5IxS1elyLrsnmwuQFK6Py5Do/LkXXYXIbC5AUro/LkOj8uRddhchsLkBSuj8uQ6Py5F12FyGwuQFNhq7IydG2W/ZQsBUOjbMkNW2WuwsBWFq2ZYauIsdgBo6er6R92G0aoZH3ADxI9AA/9k="/>
    <h1>10</h1>
    <img style="height:30px;width:30px" src="http://icons.iconarchive.com/icons/custom-icon-design/office/256/down-icon.png"/>
  </div>
</div>
<c:if test="${!empty signature}">
  <div class="signature-conatiner">
    <hr/>
        <span class='signature'>
            <jtalks:bb2html bbCode="${signature}"/>
        </span>
  </div>
</c:if>