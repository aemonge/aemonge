// Utility function to extract hash-like from iframe URL
function createHashFromIframeUrl(url) {
  try {
    const parsed = new URL(url);
    const pathSegments = parsed.pathname.split('/').filter(p => p);

    // Skip "articles" and ensure minimum depth
    if (pathSegments[0] !== 'articles' || pathSegments.length < 2) return '';

    const relevantSegments = pathSegments.slice(1);
    const lastSegment = relevantSegments.pop().replace(/\.html$/, '');
    return '#' + [...relevantSegments, lastSegment].join('__');
  } catch {
    return '';
  }
}

// Convert hash to iframe src path
function hashToIframePath(hash) {
  const hashValue = hash.substring(1);
  if (!hashValue) return '/articles/home.html';

  const segments = hashValue.split('__');
  const lastSegment = segments.pop() + '.html';
  return `/articles/${[...segments, lastSegment].join('/')}`;
}

// Main synchronization logic
document.addEventListener('DOMContentLoaded', () => {
  const iframe = document.getElementById('content');
  let ignoreHashChange = false;
  let ignoreIframeLoad = false;

  // Iframe -> Parent sync
  iframe.addEventListener('load', () => {
    if (ignoreIframeLoad) {
      ignoreIframeLoad = false;
      return;
    }

    const newHash = createHashFromIframeUrl(iframe.contentWindow.location.href);
    if (newHash && window.location.hash !== newHash) {
      ignoreHashChange = true;
      window.location.hash = newHash;
    }
  });

  // Parent -> Iframe sync
  window.addEventListener('hashchange', () => {
    if (ignoreHashChange) {
      ignoreHashChange = false;
      return;
    }

    const targetSrc = hashToIframePath(window.location.hash);
    if (iframe.src !== targetSrc) {
      ignoreIframeLoad = true;
      iframe.src = targetSrc;
    }
  });

  // Initial page load handling
  const initialHash = window.location.hash;
  if (initialHash) {
    iframe.src = hashToIframePath(initialHash);
  }
});
