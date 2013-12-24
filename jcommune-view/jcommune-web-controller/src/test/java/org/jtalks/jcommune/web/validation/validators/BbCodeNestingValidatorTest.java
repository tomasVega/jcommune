/**
 * Copyright (C) 2011  JTalks.org Team
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */
package org.jtalks.jcommune.web.validation.validators;

import org.jtalks.jcommune.model.entity.JCUser;
import org.jtalks.jcommune.service.UserService;
import org.jtalks.jcommune.web.validation.annotations.BbCodeNesting;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import static org.apache.commons.lang.StringUtils.repeat;
import org.junit.Assert;
import org.mockito.Mock;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;
import static org.testng.Assert.assertFalse;
import static org.testng.Assert.assertTrue;

public class BbCodeNestingValidatorTest {
    private BbCodeNestingValidator bbCodeNestingValidator;
    @Mock
    private UserService userService;
    @Mock
    private BbCodeNesting annotation;
        
    @BeforeMethod
    public void initMocks() throws NoSuchFieldException {
        MockitoAnnotations.initMocks(this);
        
        when(annotation.maxNestingValue()).thenReturn(2);
        when(userService.getCurrentUser()).thenReturn(new JCUser("", "", ""));
        
        bbCodeNestingValidator = new BbCodeNestingValidator(userService);
        bbCodeNestingValidator.initialize(annotation);
    }

    @Test
    public void testTooDeepNestingWithListItems() {
        assertFalse(bbCodeNestingValidator.isValid("[list][*]zzz[list][*]zzz[/*][/list][/*][/list]", null),
                    "Nesting limit is 2, but actual nesting is 4");        
    }
    
    @Test
    public void testListItemsNesting() {
        assertFalse(bbCodeNestingValidator.isValid("[list][*]zzz[list][*]zzz[/*][/list][/*][/list]", null),
                    "Nesting limit is 2, but actual nesting is 4");
        assertTrue(bbCodeNestingValidator.isValid("[*][*][*][*][*]", null), "limit doesn't affect [*]");
    }
    
    @Test
    public void testNestingLimit() {
        assertInvalid("[b][b][b]text", "The limit is 2, actual nesting is 3");
        assertInvalid("[b][b][b]text[/b][/b][/b]", "The limit is 2, actual nesting is 3");
        assertValid("[b][b]text[/b][/b]", "The limit is 2, actual nesting is 2");
        assertValid("[/b][/b][/b][/b][/b][/b]", "The limit doesn't affect closing tags without respective open tags");
        assertValid("[b]1[/b]2[b]3[/b]4[b]5[/b]6[b]7[/b]8[b]9[/b]", "The limit is 2, actual nesting is 1");
    }
    
    @Test
    public void testQuotes() {
        assertInvalid("[quote][b][b]text[/b][/b][/quote]", "The limit is 2, actual nesting is 3");
        assertValid("[quote][b]text[/b][/quote]", "The limit is 2, actual nesting is 2");
    }
    
    @Test
    public void testNamedQuotes() {
        assertValid("[quote=\"name\"][b]text[/b][/qoute]");
        assertInvalid("[quote=\"name\"][b][b]text[/b][/b][/qoute]");
    }

    void assertValid(String toValidate) {
        assertValid(toValidate, null);
    }
    
    public void assertValid(String toValidate, String message) {
        if (!bbCodeNestingValidator.isValid(toValidate, null)) {
            if (message == null) {
                Assert.fail(toValidate + ": expected <valid>, but was <invalid>");
            } else {
                Assert.fail(toValidate + " : " + message + ": expected <valid>, but was <invalid>");
            }
        }
    }
    
    public void assertInvalid(String toValidate, String message) {
        if (bbCodeNestingValidator.isValid(toValidate, null)) {
            if (message == null) {
                Assert.fail(toValidate + ": expected <invalid>, but was <valid>");
            } else {
                Assert.fail(toValidate + " : "  + message + ": expected <invalid>, but was <valid>");
            }
        }
    }

    @Test
    public void nullAndEmptyStringShouldBeTreatedAsValid() {
        assertTrue(bbCodeNestingValidator.isValid(null, null));
        assertTrue(bbCodeNestingValidator.isValid("", null));
    }
    
    @DataProvider
    public String[][] validMessages() {
        return new String[][]{ // {"message"}
                {"[b][/b][b][/b][u][/u][u][/u][u][u][u][/u][/u][/u]"},
                {"[b][/b][b][/b][u][/u][u]text[/u][u][u][u][/u][/u][/u]text"},
                {"[u][/u]"},
                {"text"},
                {"[*][*][*][*][*][*][*][*][*][*][*][*][*][*][*]"},
                {repeat("[b]",50)},
                {"[quote=\"name\"]"+repeat("[b]",49)+"[//quote]"},
                {repeat("[*]",51)},
                {repeat("[/u]",50)},
                {"[quote="+repeat("[/b]",49)+"]text[/quote]"},
                {repeat("[quote=\"abc\"]text[/quote]",51)},
                {repeat("[quote][/quote]",100)},
                {"[quote="+repeat("[b]",50)+"]text[/quote]"},
                {repeat("[url=http://javatalks.ru/ftopic14473.php]text[/url]", 100)},
                {repeat("[ERROR]", 100)}
        };
    }

    @DataProvider
    public String[][] tooDeepNestingMessages() {
        return new String[][]{ // {"message"}
                {repeat("[b]",51)},
                {repeat("[color][u]",50)},
                {repeat("[/u]",51)},
                {"[quote=\"name\"]"+repeat("[b]",50)+"[//quote]"},
                {"[quote=\"Имя%%%+===hhh\"]"+repeat("[b]",50)+"[//quote]"},
                {"[quote="+repeat("[b]",51)+"]text[//quote]"},
                {repeat("[quote=[url=123]]",51)},
                {repeat("[quote=\"\"]",51)},
                {"[quote=\""+repeat("[url=123]",51)+"\"]"}
        };
    }

    private void assertInvalid(String toValidate) {
        assertInvalid(toValidate, null);
    }
}
