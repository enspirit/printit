window.PrintIt = (function(){

    function PrintIt(options) {
        this.options = options;
        this.options.url =  this.options.url || '/';
    }    

    PrintIt.prototype.install = function() {
        this.div = document.createElement('div');
        this.div.innerHTML = '<form action="'+this.options.url+'" method="POST" target="_blank" style="display: none"><textarea name="html"></textarea><input type="hidden" name="attachment"><input type="hidden" name="accept"></form>';
        document.body.appendChild(this.div);
    } 

    PrintIt.prototype.uninstall = function() {
        if (!this.div) return;
        document.body.removeChild(this.div);
        this.div = null;
    }

    PrintIt.prototype.print = function(html, options) {
        this.install();

        if (typeof html === 'object') {
            options = html;
            html = undefined;
        }

        html = html || document.documentElement.outerHTML;
        options = options || {}

        var form = this.div.getElementsByTagName("form")[0];

        // set main html into the textare
        var area = form.getElementsByTagName("textarea")[0];
        area.value = html;

        // set options
        for (var key in options) {
            var value = options[key];
            var field = form.elements[key];
            if (field) {
                field.value = value;
            }
        }

        form.submit();

        this.uninstall();
    }

    return PrintIt;
})();
