# Base image: Ruby with necessary dependencies for Jekyll
FROM ruby:3.2

ARG CODEX_VERSION=0.145.0

# Install system dependencies used by Jekyll and the Codex installer.
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    curl \
    ca-certificates \
    gawk \
    && rm -rf /var/lib/apt/lists/*

# Create the non-root Codespaces user and use Bash for interactive terminals.
RUN groupadd -g 1000 vscode && \
    useradd -m -u 1000 -g vscode -s /bin/bash vscode

ENV HOME=/home/vscode
ENV PATH="/home/vscode/.local/bin:${PATH}"

WORKDIR /usr/src/app
RUN chown -R vscode:vscode /usr/src/app

USER vscode

# Install a pinned Codex CLI release non-interactively so container builds cannot
# stop at the installer's "Start Codex now?" prompt.
RUN curl -fsSL https://chatgpt.com/codex/install.sh -o /tmp/install-codex.sh \
    && CODEX_NON_INTERACTIVE=1 sh /tmp/install-codex.sh --release "${CODEX_VERSION}" \
    && rm /tmp/install-codex.sh \
    && codex --version

# Install the Ruby dependencies used by the site.
COPY --chown=vscode:vscode Gemfile ./
RUN gem install connection_pool:2.5.0 \
    && gem install bundler:2.3.26 \
    && bundle install

CMD ["jekyll", "serve", "-H", "0.0.0.0", "-w", "--config", "_config.yml,_config_docker.yml"]
