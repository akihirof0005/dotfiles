RUBY_FLAG=$(cat config.json | jq .languages.ruby.enable)
RUBY_VER=$(cat config.json | jq -r .languages.ruby.version)
RUBY_MODULES=$(cat config.json | jq -r .languages.ruby.modules[] | tr '\n' ' ')
echo "#######RUBY########"
echo "STATUS : "$RUBY_FLAG
echo "VERSION: "$RUBY_VER
echo "MODULES: "$RUBY_MODULES
echo "#######END#########"
echo ""

NODE_FLAG=$(cat config.json | jq .languages.nodejs.enable)
NODE_VER=$(cat config.json | jq -r .languages.nodejs.version)
NODE_MODULES=$(cat config.json | jq -r .languages.nodejs.modules[] | tr '\n' ' ')

echo "#######NODEJS######"
echo "STATUS : "$NODE_FLAG
echo "VERSION: "$NODE_VER
echo "MODULES: "$NODE_MODULES
echo "#######END#########"
echo ""

JVM_FLAG=$(cat config.json | jq .languages.jvm.enable)
JVM_VER=$(cat config.json | jq -r .languages.jvm.version)
JVM_MODULES=$(cat config.json | jq -r .languages.jvm.modules[] | tr '\n' ' ')

echo "#######JVM######"
echo "STATUS : "$JVM_FLAG
echo "VERSION: "$JVM_VER
echo "MODULES: "$JVM_MODULES
echo "#######END#########"
echo ""
